#![no_main]
#![no_std]

#[rtic::app(device = stm32f4xx_hal::pac, peripherals = true)]
mod app {
    use panic_halt as _;

    use keyboard_labs_keyberon::app_prelude::*;

    use stm32f4xx_hal::gpio::{EPin, Input, Output, PushPull};
pub use stm32f4xx_hal::timer::delay::DelayUs;

    use keyboard_labs_keyberon::layouts::ortho_5x12::{COLS, ROWS, CHORDS, NUM_CHORDS, LAYERS, Layout};
    use keyboard_labs_keyberon::pinout::x_2::rev2021_1::cols_and_rows_for_peripherals;
    use keyboard_labs_keyberon::matrix::Matrix as DelayedMatrix;

    #[shared]
    struct SharedResources {
        usb_dev: UsbDevice,
        usb_class: UsbClass,
    }

    #[local]
    struct LocalResources {
        timer: timer::CounterUs<pac::TIM3>,
        matrix: DelayedMatrix<EPin<Input>, EPin<Output<PushPull>>, COLS, ROWS, 1_000_000>,
        debouncer: Debouncer<[[bool; COLS]; ROWS]>,
        chording: Chording<NUM_CHORDS>,
        layout: Layout,
    }

    #[init(local = [
        ep_memory: [u32; 1024] = [0; 1024],
        usb_bus: Option<UsbBusAllocator<UsbBusType>> = None
    ])]
    fn init(c: init::Context) -> (SharedResources, LocalResources, init::Monotonics) {
        let init::Context { device, .. } = c;
        let clocks = app_init::init_clocks(device.RCC.constrain());
        let gpio::gpioa::Parts { pa3, pa4, pa5, pa6, pa7, pa8, pa10, pa11, pa12, pa15, .. } = device.GPIOA.split();
        let gpio::gpiob::Parts { pb1, pb5, pb6, pb7, pb8, pb12, pb13, pb14, pb15, .. } = device.GPIOB.split();

        let usb = USB::new(
            (device.OTG_FS_GLOBAL, device.OTG_FS_DEVICE, device.OTG_FS_PWRCLK),
            (pa11, pa12),
            &clocks,
        );

        *c.local.usb_bus = Some(UsbBusType::new(usb, c.local.ep_memory));
        let usb_bus = c.local.usb_bus.as_ref().unwrap();

        let (usb_dev, usb_class) = app_init::init_usb_device(usb_bus);

        let timer = app_init::init_timer(&clocks, device.TIM3);

        let delay: DelayUs<pac::TIM5> = device.TIM5.delay_us(&clocks);
        let (cols, rows) = cols_and_rows_for_peripherals(
            pa3,
            pa4,
            pa5,
            pa6,
            pa7,
            pa8,
            pa10,
            pa15,
            pb1,
            pb5,
            pb6,
            pb7,
            pb8,
            pb12,
            pb13,
            pb14,
            pb15,
        );
        let matrix = DelayedMatrix::new(
            cols,
            rows,
            delay,
            5, // select pin delay
            5, // unselect pin delay
        );

        (
            SharedResources { usb_dev, usb_class },
            LocalResources {
                timer,
                matrix: matrix.unwrap(),
                debouncer: Debouncer::new([[false; COLS]; ROWS], [[false; COLS]; ROWS], 25),
                chording: Chording::new(&CHORDS),
                layout: Layout::new(&LAYERS),
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

    #[task(binds = TIM3, priority = 1, shared = [usb_class], local = [matrix, debouncer, layout, chording, timer])]
    fn tick(c: tick::Context) {
        let tick::SharedResources { mut usb_class } = c.shared;
        let tick::LocalResources { timer, matrix, debouncer, chording, layout } = c.local;

        timer.clear_interrupt(timer::Event::Update);

        for event in keyboard_events(matrix, debouncer, chording) {
            layout.event(event);
        }
        match layout.tick() {
            _ => (),
        }

        usb_class.lock(|mut k| send_report(layout.keycodes(), &mut k));
    }
}
