#![no_main]
#![no_std]

#[rtic::app(device = stm32f4xx_hal::pac, peripherals = true, dispatchers = [SPI1])]
mod app {
    // set the panic handler
    use panic_halt as _;

    use keyberon::debounce::Debouncer;
    use keyberon::layout::Event;
    use nb::block;
    use stm32f4xx_hal::otg_fs::{UsbBusType, USB};
    use stm32f4xx_hal::prelude::*;
    use stm32f4xx_hal::serial;
    use stm32f4xx_hal::serial::config::Config;
    use stm32f4xx_hal::{pac, timer};
    use usb_device::prelude::UsbDeviceState;
    use usb_device::bus::UsbBusAllocator;

    use usbd_human_interface_device::usb_class::UsbHidClassBuilder;

    use keyboard_labs_keyberon::common::{
        UsbClass,
        UsbDevice,
        de,
        ser,
        send_report,
        usb_poll,
    };
    use keyboard_labs_keyberon::direct_pin_matrix::{
        DirectPins,
        PressedKeys5x4,
    };
    use keyboard_labs_keyberon::layouts::minif4_36::{LAYERS, Layout};
    use keyboard_labs_keyberon::pinout::minif4_36::rev2021_5::rhs::{
        DirectPins5x4,
        direct_pin_matrix_for_peripherals,
        event_transform,
    };

    #[shared]
    struct SharedResources {
        usb_dev: UsbDevice,
        usb_class: UsbClass,
    }

    #[local]
    struct LocalResources {
        direct_pins: DirectPins5x4,
        debouncer: Debouncer<PressedKeys5x4>,
        layout: Layout,
        timer: timer::CounterUs<pac::TIM3>,
        tx: serial::Tx<stm32f4xx_hal::pac::USART1>,
        rx: serial::Rx<stm32f4xx_hal::pac::USART1>,
    }

    #[init(local = [
        ep_memory: [u32; 1024] = [0; 1024],
        usb_bus: Option<UsbBusAllocator<UsbBusType>> = None
    ])]
    fn init(c: init::Context) -> (SharedResources, LocalResources, init::Monotonics) {
        let rcc = c.device.RCC.constrain();
        let clocks = rcc
            .cfgr
            .use_hse(25.MHz())
            .sysclk(84.MHz())
            .require_pll48clk()
            .freeze();
        let gpioa = c.device.GPIOA.split();
        let gpiob = c.device.GPIOB.split();
        let gpioc = c.device.GPIOC.split();

        let usb = USB {
            usb_global: c.device.OTG_FS_GLOBAL,
            usb_device: c.device.OTG_FS_DEVICE,
            usb_pwrclk: c.device.OTG_FS_PWRCLK,
            pin_dm: stm32f4xx_hal::gpio::alt::otg_fs::Dm::PA11(gpioa.pa11.into_alternate()),
            pin_dp: stm32f4xx_hal::gpio::alt::otg_fs::Dp::PA12(gpioa.pa12.into_alternate()),
            hclk: clocks.hclk(),
        };
        *c.local.usb_bus = Some(UsbBusType::new(usb, c.local.ep_memory));
        let usb_bus = c.local.usb_bus.as_ref().unwrap();

        let usb_class = UsbHidClassBuilder::new()
            .add_device(
                usbd_human_interface_device::device::keyboard::NKROBootKeyboardConfig::default(),
            )
            .build(usb_bus);

        let usb_dev = keyberon::new_device(usb_bus);

        let mut timer = c.device.TIM3.counter_us(&clocks);
        timer.start(1.millis()).unwrap();
        timer.listen(timer::Event::Update);
        unsafe {
            pac::NVIC::unmask(pac::Interrupt::OTG_FS);
            pac::NVIC::unmask(pac::Interrupt::OTG_FS_WKUP);
            pac::NVIC::unmask(pac::Interrupt::TIM3);
            pac::NVIC::unmask(pac::Interrupt::USART1);
        }

        let direct_pins = direct_pin_matrix_for_peripherals(
            gpioa.pa0,
            gpioa.pa2,
            gpioa.pa4,
            gpioa.pa5,
            gpioa.pa6,
            gpioa.pa8,
            gpioa.pa9,
            gpioa.pa10,
            gpioa.pa15,
            gpiob.pb1,
            gpiob.pb3,
            gpiob.pb5,
            gpiob.pb10,
            gpiob.pb12,
            gpiob.pb13,
            gpiob.pb14,
            gpiob.pb15,
            gpioc.pc13,
        );

        let pins = (
            gpiob.pb6.into_alternate(),
            gpiob.pb7.into_alternate(),
        );
        let mut serial = serial::Serial::new(
            c.device.USART1,
            pins,
            Config::default().baudrate(9_600.bps()),
            &clocks,
        )
        .unwrap();
        serial.listen(serial::Event::Rxne);
        let (tx, rx) = serial.split();

        (
            SharedResources {
                usb_dev,
                usb_class,
            },
            LocalResources {
                timer,
                // 5x12 debouncer
                debouncer: Debouncer::new(PressedKeys5x4::default(), PressedKeys5x4::default(), 5),
                direct_pins,
                tx,
                rx,
                layout: Layout::new(&LAYERS),
            },
            init::Monotonics(),
        )
    }

    /// Handle input from the TRRS cable.
    ///
    /// Spawns keyberon Events for each message that
    /// can be deserialised from UART1.
    ///
    /// This is how the split-half which isn't connected to
    /// the computer with USB can still have its key presses
    /// sent to the computer.
    #[task(binds = USART1, priority = 5, local = [buf: [u8; 4] = [0; 4], rx])]
    fn rx(c: rx::Context) {
        if let Ok(b) = c.local.rx.read() {
            c.local.buf.rotate_left(1);
            c.local.buf[3] = b;

            if c.local.buf[3] == b'\n' {
                if let Ok(event) = de(&c.local.buf[..]) {
                    handle_event::spawn(Some(event)).unwrap();
                }
            }
        }
    }

    /// Poll the USB device for the OTG_FS interrupt.
    #[task(binds = OTG_FS, priority = 4, shared = [usb_class, usb_dev])]
    fn usb_tx(c: usb_tx::Context) {
        let usb_tx::SharedResources { usb_dev, usb_class } = c.shared;
        (usb_dev, usb_class).lock(|mut ud, mut uc| usb_poll(&mut ud, &mut uc));
    }

    /// Poll the USB device for the OTG_FS_WKUP interrupt.
    #[task(binds = OTG_FS_WKUP, priority = 4, shared = [usb_class, usb_dev])]
    fn usb_rx(c: usb_rx::Context) {
        let usb_rx::SharedResources { usb_dev, usb_class } = c.shared;
        (usb_dev, usb_class).lock(|mut ud, mut uc| usb_poll(&mut ud, &mut uc));
    }

    /// Handles keyberon Events and sends the resulting HID report
    /// to the computer.
    ///
    /// When `event` is Some(event), the keyberon layout is
    /// updated with this event. When `event` is None,
    /// a layout tick occurs and the resulting report is written.
    /// i.e. this task should be spawned with None as the event
    /// every tick.
    #[task(priority = 3, capacity = 8, shared = [usb_class, usb_dev], local = [layout])]
    fn handle_event(c: handle_event::Context, event: Option<Event>) {
        let handle_event::SharedResources { mut usb_class, mut usb_dev } = c.shared;
        let handle_event::LocalResources { layout } = c.local;
        match event {
            None => {
                layout.tick();

                // Check the USB connection is in a good state.
                if usb_dev.lock(|d| d.state()) != UsbDeviceState::Configured {
                    return;
                }

                usb_class.lock(|uc| send_report(layout.keycodes(), uc))
            }
            Some(e) => {
                // Update the keyberon layout state with the event.
                layout.event(e);
            }
        };
    }

    #[task(
        binds = TIM3,
        priority = 2,
        local = [
            debouncer,
            direct_pins,
            timer,
            tx,
        ]
    )]
    fn tick(c: tick::Context) {
        c.local.timer.clear_interrupt(timer::Event::Update);

        // Construct the keyberon events by reading from the gpio
        // pins, debouncing the inputs, and transforming the values
        // for left/right-hand split half.
        for event in c
            .local
            .debouncer
            .events(c.local.direct_pins.get().unwrap())
            .map(event_transform)
        {
            // Send the event across the TRRS cable.
            for &b in &ser(event) {
                block!(c.local.tx.write(b)).unwrap();
            }
            block!(c.local.tx.flush()).unwrap();

            // update the keyberon layout with the event.
            handle_event::spawn(Some(event)).unwrap();
        }

        // update the keyberon layout & send the HID report to the computer.
        handle_event::spawn(None).unwrap();
    }
}
