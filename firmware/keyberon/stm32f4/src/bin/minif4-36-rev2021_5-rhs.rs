#![no_main]
#![no_std]

#[rtic::app(device = stm32f4xx_hal::pac, peripherals = true, dispatchers = [SPI1])]
mod app {
    use panic_halt as _;

    use keyboard_labs_keyberon::input::PressedKeys5x4;
    use keyboard_labs_keyberon::layouts::split_3x5_3::rgoulter::matrix4x10::{
        Layout, CHORDS, LAYERS, NUM_CHORDS,
    };
    use keyboard_labs_keyberon_stm32f4::pinout::minif4_36::rev2021_5::rhs::{
        direct_pin_matrix_for_peripherals, event_transform, Keyboard,
    };
    use keyboard_labs_keyberon_stm32f4::split::app_prelude::*;

    #[shared]
    struct SharedResources {
        usb_dev: UsbDevice,
        usb_class: UsbClass,
    }

    #[local]
    struct LocalResources {
        timer: timer::CounterUs<pac::TIM3>,
        keyboard: Keyboard<NUM_CHORDS>,
        layout: Layout,
        split_conn_tx: TransportWriter,
        split_conn_rx: TransportReader,
    }

    #[init(local = [
        ep_memory: [u32; 1024] = [0; 1024],
        rx_buf: [u8; 4] = [0; 4],
        usb_bus: Option<UsbBusAllocator<UsbBusType>> = None
    ])]
    fn init(c: init::Context) -> (SharedResources, LocalResources, init::Monotonics) {
        let init::Context { device, .. } = c;
        let gpio::gpioa::Parts {
            pa0,
            pa2,
            pa4,
            pa5,
            pa6,
            pa8,
            pa9,
            pa10,
            pa11,
            pa12,
            pa15,
            ..
        } = device.GPIOA.split();
        let gpio::gpiob::Parts {
            pb1,
            pb3,
            pb5,
            pb6,
            pb7,
            pb10,
            pb12,
            pb13,
            pb14,
            pb15,
            ..
        } = device.GPIOB.split();
        let gpio::gpioc::Parts { pc13, .. } = device.GPIOC.split();

        let clocks = app_init::init_clocks(device.RCC.constrain());

        let usb = USB::new(
            (
                device.OTG_FS_GLOBAL,
                device.OTG_FS_DEVICE,
                device.OTG_FS_PWRCLK,
            ),
            (pa11, pa12),
            &clocks,
        );

        *c.local.usb_bus = Some(UsbBusType::new(usb, c.local.ep_memory));
        let usb_bus = c.local.usb_bus.as_ref().unwrap();

        let (usb_dev, usb_class) =
            app_init::init_usb_device(usb_bus, VID, 0x0001, MANUFACTURER, "MiniF4-36");

        let timer = app_init::init_timer(&clocks, device.TIM3);

        let matrix = direct_pin_matrix_for_peripherals(
            pa0, pa2, pa4, pa5, pa6, pa8, pa9, pa10, pa15, pb1, pb3, pb5, pb10, pb12, pb13, pb14,
            pb15, pc13,
        );

        let keyboard = Keyboard {
            matrix,
            debouncer: Debouncer::new(PressedKeys5x4::default(), PressedKeys5x4::default(), 5),
            chording: Chording::new(&CHORDS),
        };

        let (split_conn_tx, split_conn_rx) = split_app_init::init_serial(&clocks, pb6, pb7, device.USART1, c.local.rx_buf);

        (
            SharedResources { usb_dev, usb_class },
            LocalResources {
                timer,
                keyboard,
                layout: Layout::new(&LAYERS),
                split_conn_tx,
                split_conn_rx,
            },
            init::Monotonics(),
        )
    }

    #[task(binds = USART1, priority = 5, local = [split_conn_rx])]
    fn rx(c: rx::Context) {
        let rx::LocalResources { split_conn_rx } = c.local;
        if let Some(event) = split_conn_rx.read() {
            // Received Event from other keyboard half,
            // which are for that half's matrix.
            // Hence, need to transform it.
            let transformed_event = event_transform(event);
            layout::spawn(LayoutMessage::Event(transformed_event)).unwrap();
        }
    }

    #[task(binds = OTG_FS, priority = 4, shared = [usb_class, usb_dev])]
    fn usb_tx(c: usb_tx::Context) {
        let usb_tx::SharedResources { usb_dev, usb_class } = c.shared;
        (usb_dev, usb_class).lock(|mut ud, mut uc| usb_poll(&mut ud, &mut uc));
    }

    #[task(binds = OTG_FS_WKUP, priority = 4, shared = [usb_class, usb_dev])]
    fn usb_rx(c: usb_rx::Context) {
        let usb_rx::SharedResources { usb_dev, usb_class } = c.shared;
        (usb_dev, usb_class).lock(|mut ud, mut uc| usb_poll(&mut ud, &mut uc));
    }

    #[task(priority = 3, capacity = 8, shared = [usb_class, usb_dev], local = [layout])]
    fn layout(c: layout::Context, message: LayoutMessage) {
        let layout::SharedResources {
            mut usb_class,
            mut usb_dev,
        } = c.shared;
        let layout::LocalResources { layout } = c.local;
        match message {
            LayoutMessage::Tick => {
                layout.tick();

                if usb_dev.lock(|d| d.state()) != UsbDeviceState::Configured {
                    return;
                }

                usb_class.lock(|uc| send_report(layout.keycodes(), uc))
            }
            LayoutMessage::Event(e) => {
                layout.event(e);
            }
        };
    }

    #[task(
        binds = TIM3,
        priority = 2,
        local = [
            timer,
            keyboard,
            split_conn_tx,
        ]
    )]
    fn tick(c: tick::Context) {
        let tick::LocalResources {
            timer,
            keyboard,
            split_conn_tx,
        } = c.local;

        timer.clear_interrupt(timer::Event::Update);

        for event in keyboard.events() {
            split_conn_tx.write(event);
            layout::spawn(LayoutMessage::Event(event)).unwrap();
        }

        layout::spawn(LayoutMessage::Tick).unwrap();
    }
}
