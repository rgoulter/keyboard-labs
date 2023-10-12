#![no_main]
#![no_std]

#[rtic::app(device = stm32f4xx_hal::pac, peripherals = true)]
mod app {
    // set the panic handler
    use panic_rtt_target as _;

    use core::convert::Infallible;

    use keyberon::debounce::Debouncer;
    use rtt_target::{rprintln, rtt_init_print};
    use stm32f4xx_hal::gpio::gpioa;
    use stm32f4xx_hal::gpio::Input;
    use stm32f4xx_hal::otg_fs::{UsbBusType, USB};
    use stm32f4xx_hal::prelude::*;
    use stm32f4xx_hal::{pac, timer};
    use usb_device::bus::UsbBusAllocator;
    use usb_device::prelude::*;
    use usbd_human_interface_device::page::Keyboard;
    use usbd_human_interface_device::usb_class::UsbHidClassBuilder;
    use usbd_human_interface_device::UsbHidError;

    use keyboard_labs_keyberon::common::Matrix;
    use keyboard_labs_keyberon::direct_pin_matrix::PressedKeys1x1;

    use keyboard_labs_keyberon_stm32f4::common::{UsbClass, UsbDevice};

    const COLS: usize = 1;
    const ROWS: usize = 1;
    const NUM_LAYERS: usize = 1;

    type CustomAction = ();
    type Layers = keyberon::layout::Layers<COLS, ROWS, NUM_LAYERS, CustomAction, Keyboard>;
    type Layout = keyberon::layout::Layout<COLS, ROWS, NUM_LAYERS, CustomAction, Keyboard>;

    pub static LAYERS: Layers = [[[keyboard_labs_keyberon::layouts::common::a!(A)]]];

    pub struct DirectPins1x1(pub (gpioa::PA0<Input>,));

    impl Matrix<COLS, ROWS> for DirectPins1x1 {
        fn get(&mut self) -> Result<PressedKeys1x1, Infallible> {
            let row1 = &self.0;
            Ok([[row1.0.is_low()]])
        }
    }

    #[shared]
    struct SharedResources {
        usb_dev: UsbDevice,
        usb_class: UsbClass,
    }

    #[local]
    struct LocalResources {
        direct_pins: DirectPins1x1,
        debouncer: Debouncer<PressedKeys1x1>,
        layout: Layout,
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

        rtt_init_print!();
        rprintln!("init");

        let gpioa = c.device.GPIOA.split();

        let usb = USB::new(
            (
                c.device.OTG_FS_GLOBAL,
                c.device.OTG_FS_DEVICE,
                c.device.OTG_FS_PWRCLK,
            ),
            (gpioa.pa11, gpioa.pa12),
            &clocks,
        );
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

        let direct_pins = DirectPins1x1((gpioa.pa0.into_pull_up_input(),));

        (
            SharedResources { usb_dev, usb_class },
            LocalResources {
                timer,
                // 1x1 debouncer
                debouncer: Debouncer::new(PressedKeys1x1::default(), PressedKeys1x1::default(), 5),
                direct_pins,
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

    #[task(binds = TIM3, priority = 1, shared = [usb_class], local = [direct_pins, debouncer, layout, timer])]
    fn tick(c: tick::Context) {
        c.local.timer.clear_interrupt(timer::Event::Update);

        let pressed_keys: PressedKeys1x1 = c.local.direct_pins.get().unwrap();
        let events = c.local.debouncer.events(pressed_keys);

        for event in events {
            c.local.layout.event(event);
        }
        match c.local.layout.tick() {
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
                Ok(_leds) => {}
            }
        }
    }
}
