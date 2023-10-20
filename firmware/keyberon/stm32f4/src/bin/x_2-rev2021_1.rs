#![no_main]
#![no_std]

#[rtic::app(device = stm32f4xx_hal::pac, peripherals = true)]
mod app {
    use panic_halt as _;

    use keyboard_labs_keyberon_stm32f4::app_prelude::*;

    pub use stm32f4xx_hal::timer::delay::DelayUs;

    use keyboard_labs_keyberon::input::PressedKeys12x5;
    use keyboard_labs_keyberon::layouts::ortho_5x12::rgoulter::{
        KeyboardBackend, Layout, CHORDS, LAYERS, NUM_CHORDS,
    };
    use keyboard_labs_keyberon::matrix::Matrix as DelayedMatrix;
    use keyboard_labs_keyberon_stm32f4::pinout::x_2::rev2021_1;

    #[shared]
    struct SharedResources {
        usb_dev: UsbDevice,
        usb_class: UsbClass,
    }

    #[local]
    struct LocalResources {
        timer: timer::CounterUs<pac::TIM3>,
        keyboard: rev2021_1::Keyboard<NUM_CHORDS, pac::TIM5>,
        backend: KeyboardBackend,
    }

    #[init(local = [
        ep_memory: [u32; 1024] = [0; 1024],
        usb_bus: Option<UsbBusAllocator<UsbBusType>> = None
    ])]
    fn init(c: init::Context) -> (SharedResources, LocalResources, init::Monotonics) {
        let init::Context { device, .. } = c;
        let clocks = app_init::init_clocks(device.RCC.constrain());
        let gpio::gpioa::Parts {
            pa3,
            pa4,
            pa5,
            pa6,
            pa7,
            pa8,
            pa10,
            pa11,
            pa12,
            pa15,
            ..
        } = device.GPIOA.split();
        let gpio::gpiob::Parts {
            pb1,
            pb5,
            pb6,
            pb7,
            pb8,
            pb12,
            pb13,
            pb14,
            pb15,
            ..
        } = device.GPIOB.split();

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
            app_init::init_usb_device(usb_bus, VID, 0x0002, MANUFACTURER, "X-2 Lumberjack ARM");

        let timer = app_init::init_timer(&clocks, device.TIM3);

        let delay: DelayUs<pac::TIM5> = device.TIM5.delay_us(&clocks);
        let cols = rev2021_1::cols(
            pa3, pa4, pa5, pa6, pa7, pa8, pa15, pb1, pb12, pb13, pb14, pb15,
        );
        let rows = rev2021_1::rows(pa10, pb5, pb6, pb7, pb8);
        let matrix = DelayedMatrix::new(cols, rows, delay, 5, 5).unwrap();
        let keyboard = rev2021_1::Keyboard {
            matrix,
            debouncer: Debouncer::new(PressedKeys12x5::default(), PressedKeys12x5::default(), 25),
            chording: Chording::new(&CHORDS),
        };

        let layout = Layout::new(&LAYERS);
        let backend = KeyboardBackend::new(layout);

        (
            SharedResources { usb_dev, usb_class },
            LocalResources {
                timer,
                keyboard,
                backend,
            },
            init::Monotonics(),
        )
    }

    #[task(binds = OTG_FS, priority = 2, shared = [usb_dev, usb_class])]
    fn usb_tx(c: usb_tx::Context) {
        let usb_tx::SharedResources { usb_dev, usb_class } = c.shared;
        (usb_dev, usb_class).lock(|mut ud, mut uc| usb_poll(&mut ud, &mut uc));
    }

    #[task(binds = OTG_FS_WKUP, priority = 2, shared = [usb_dev, usb_class])]
    fn usb_rx(c: usb_rx::Context) {
        let usb_rx::SharedResources { usb_dev, usb_class } = c.shared;
        (usb_dev, usb_class).lock(|mut ud, mut uc| usb_poll(&mut ud, &mut uc));
    }

    #[task(binds = TIM3, priority = 1, shared = [usb_class], local = [timer, keyboard, backend])]
    fn tick(c: tick::Context) {
        let tick::SharedResources { mut usb_class } = c.shared;
        let tick::LocalResources {
            timer,
            keyboard,
            backend,
        } = c.local;

        timer.clear_interrupt(timer::Event::Update);

        for event in keyboard.events() {
            backend.event(event);
        }

        backend.tick();

        usb_class.lock(|k| {
            backend.write_reports(k);
        });
    }
}
