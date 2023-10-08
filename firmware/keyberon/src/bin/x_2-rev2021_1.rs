#![no_main]
#![no_std]

#[rtic::app(device = stm32f4xx_hal::pac, peripherals = true)]
mod app {
    // set the panic handler
    use panic_halt as _;

    use keyberon::chording::Chording;
    use keyberon::debounce::Debouncer;
    use stm32f4xx_hal::timer::delay::DelayUs;
    use stm32f4xx_hal::gpio::{EPin, Input, Output, PushPull};
    use stm32f4xx_hal::otg_fs::{UsbBusType, USB};
    use stm32f4xx_hal::prelude::*;
    use stm32f4xx_hal::{pac, timer};
    use usb_device::UsbError;
    use usb_device::bus::UsbBusAllocator;

    use usbd_human_interface_device::usb_class::UsbHidClassBuilder;
    use usbd_human_interface_device::page::Keyboard;
    use usbd_human_interface_device::UsbHidError;

    use keyboard_labs_keyberon::common::{UsbClass, UsbDevice};
    use keyboard_labs_keyberon::layouts::ortho_5x12::{COLS, ROWS, CHORDS, LAYERS, Layout};
    use keyboard_labs_keyberon::matrix::Matrix as DelayedMatrix;

    #[shared]
    struct SharedResources {
        usb_dev: UsbDevice,
        usb_class: UsbClass,
    }

    #[local]
    struct LocalResources {
        matrix: DelayedMatrix<EPin<Input>, EPin<Output<PushPull>>, COLS, ROWS, 1_000_000>,
        debouncer: Debouncer<[[bool; COLS]; ROWS]>,
        layout: Layout,
        chording: Chording<2>,
        timer: timer::CounterUs<pac::TIM3>,
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
            pac::NVIC::unmask(pac::Interrupt::TIM3);
        }

        let delay: DelayUs<pac::TIM5> = c.device.TIM5.delay_us(&clocks);
        let matrix = DelayedMatrix::new(
            [
                gpiob.pb12.into_pull_up_input().erase(), // col1
                gpiob.pb13.into_pull_up_input().erase(), // col2
                gpiob.pb14.into_pull_up_input().erase(), // col3
                gpiob.pb15.into_pull_up_input().erase(), // col4
                gpioa.pa8.into_pull_up_input().erase(),  // col5
                gpioa.pa15.into_pull_up_input().erase(), // col6
                gpioa.pa3.into_pull_up_input().erase(),  // col7
                gpioa.pa4.into_pull_up_input().erase(),  // col8
                gpioa.pa5.into_pull_up_input().erase(),  // col9
                gpioa.pa6.into_pull_up_input().erase(),  // col10
                gpioa.pa7.into_pull_up_input().erase(),  // col11
                gpiob.pb1.into_pull_up_input().erase(),  // col12
            ],
            [
                gpioa.pa10.into_push_pull_output().erase(), // row1
                gpiob.pb5.into_push_pull_output().erase(),  // row2
                gpiob.pb6.into_push_pull_output().erase(),  // row3
                gpiob.pb7.into_push_pull_output().erase(),  // row4
                gpiob.pb8.into_push_pull_output().erase(),  // row5
            ],
            delay,
            5, // select pin delay
            5, // unselect pin delay
        );

        (
            SharedResources { usb_dev, usb_class },
            LocalResources {
                timer,
                // 5x12 debouncer
                debouncer: Debouncer::new([[false; COLS]; ROWS], [[false; COLS]; ROWS], 25),
                matrix: matrix.unwrap(),
                layout: Layout::new(&LAYERS),
                chording: Chording::new(&CHORDS),
            },
            init::Monotonics(),
        )
    }

    #[task(binds = OTG_FS, priority = 2, shared = [usb_dev, usb_class])]
    fn usb_tx(c: usb_tx::Context) {
        // usb_poll(&mut c.resources.usb_dev, &mut c.resources.usb_class);
        let usb_tx::SharedResources { usb_dev, usb_class } = c.shared;
        (usb_dev, usb_class).lock(|mut ud, mut uc| usb_poll(&mut ud, &mut uc));
    }

    #[task(binds = OTG_FS_WKUP, priority = 2, shared = [usb_dev, usb_class])]
    fn usb_rx(c: usb_rx::Context) {
        // usb_poll(&mut c.resources.usb_dev, &mut c.resources.usb_class);
        let usb_rx::SharedResources { usb_dev, usb_class } = c.shared;
        (usb_dev, usb_class).lock(|mut ud, mut uc| usb_poll(&mut ud, &mut uc));
    }

    #[task(binds = TIM3, priority = 1, shared = [usb_class], local = [matrix, debouncer, layout, chording, timer])]
    fn tick(c: tick::Context) {
        c.local.timer.clear_interrupt(timer::Event::Update);

        let events = c.local.debouncer.events(c.local.matrix.get().unwrap());
        let chord_events = c.local.chording.tick(events.collect());

        for event in chord_events {
            c.local.layout.event(event);
        }
        match c.local.layout.tick() {
            keyberon::layout::CustomEvent::Release(()) => unsafe {
                cortex_m::asm::bootload(0x1FFF0000 as _)
            },
            _ => (),
        }
        let layout = c.local.layout;
        let mut usb_class = c.shared.usb_class;
        usb_class.lock(|mut k| send_report(layout.keycodes(), &mut k));
    }

    fn send_report(iter: impl Iterator<Item = Keyboard>, usb_class: &mut UsbClass) {
        match usb_class.device().write_report(iter) {
            Err(UsbHidError::WouldBlock) => {}
            Err(UsbHidError::Duplicate) => {}
            Ok(_) => {}
            Err(e) => {
                core::panic!("Failed to write keyboard report: {:?}", e)
            }
        }
    }

    fn usb_poll(usb_dev: &mut UsbDevice, keyboard: &mut UsbClass) {
        if usb_dev.poll(&mut [keyboard]) {
            let interface = keyboard.device();
            match interface.read_report() {
                Err(UsbError::WouldBlock) => {}
                Err(e) => {
                    core::panic!("Failed to read keyboard report: {:?}", e)
                }
                Ok(_leds) => {},
            }
        }
    }
}
