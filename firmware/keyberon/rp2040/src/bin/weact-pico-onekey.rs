#![no_std]
#![no_main]

#[rtic::app(
    device = rp_pico::hal::pac,
)]
mod app {
    use panic_rtt_target as _;

    use core::convert::Infallible;

    use keyberon::debounce::Debouncer;
    use rtt_target::{rprintln, rtt_init_print};

    use embedded_hal::digital::v2::InputPin;
    use fugit::ExtU32;
    use rp_pico::hal;
    use rp_pico::hal::{
        clocks, gpio, gpio::bank0::Gpio23, gpio::FunctionSio, gpio::PullDown, gpio::SioInput, pac,
        sio::Sio, timer, timer::Alarm, usb::UsbBus,
    };
    use rp_pico::XOSC_CRYSTAL_FREQ;

    use usb_device::bus::UsbBusAllocator;
    use usb_device::prelude::*;
    use usbd_human_interface_device::page::Keyboard;
    use usbd_human_interface_device::usb_class::UsbHidClassBuilder;
    use usbd_human_interface_device::UsbHidError;

    use keyboard_labs_keyberon::common::Matrix;
    use keyboard_labs_keyberon::direct_pin_matrix::PressedKeys1x1;

    use keyboard_labs_keyberon_rp2040::common::{UsbClass, UsbDevice};

    const COLS: usize = 1;
    const ROWS: usize = 1;
    const NUM_LAYERS: usize = 1;

    type CustomAction = ();
    type Layers = keyberon::layout::Layers<COLS, ROWS, NUM_LAYERS, CustomAction, Keyboard>;
    type Layout = keyberon::layout::Layout<COLS, ROWS, NUM_LAYERS, CustomAction, Keyboard>;

    pub static LAYERS: Layers = [[[keyboard_labs_keyberon::layouts::common::a!(A)]]];

    // WeAct's Pico K3 is pulled down.
    pub struct DirectPins1x1(pub (gpio::Pin<Gpio23, FunctionSio<SioInput>, PullDown>,));

    impl Matrix<COLS, ROWS> for DirectPins1x1 {
        fn get(&mut self) -> Result<PressedKeys1x1, Infallible> {
            let row1 = &self.0;
            Ok([[row1.0.is_high().unwrap()]])
        }
    }

    #[shared]
    struct Shared {
        usb_dev: UsbDevice,
        usb_class: UsbClass,
    }

    #[local]
    struct Local {
        direct_pins: DirectPins1x1,
        debouncer: Debouncer<PressedKeys1x1>,
        layout: Layout,
        alarm: timer::Alarm0,
        watchdog: hal::watchdog::Watchdog,
    }

    #[init(local=[
        ep_memory: [u32; 1024] = [0; 1024],
        usb_bus: Option<UsbBusAllocator<UsbBus>> = None
    ])]
    fn init(mut ctx: init::Context) -> (Shared, Local, init::Monotonics) {
        // Configure the clocks, watchdog - The default is to generate a 125 MHz system clock
        let mut watchdog = hal::Watchdog::new(ctx.device.WATCHDOG);
        let clocks = clocks::init_clocks_and_plls(
            XOSC_CRYSTAL_FREQ,
            ctx.device.XOSC,
            ctx.device.CLOCKS,
            ctx.device.PLL_SYS,
            ctx.device.PLL_USB,
            &mut ctx.device.RESETS,
            &mut watchdog,
        )
        .ok()
        .unwrap();

        rtt_init_print!();
        rprintln!("init");

        let mut timer = timer::Timer::new(ctx.device.TIMER, &mut ctx.device.RESETS, &clocks);
        let mut alarm = timer.alarm_0().unwrap();
        alarm.enable_interrupt();
        alarm.schedule(1.millis()).unwrap();

        // Set up the USB driver
        *ctx.local.usb_bus = Some(UsbBusAllocator::new(hal::usb::UsbBus::new(
            ctx.device.USBCTRL_REGS,
            ctx.device.USBCTRL_DPRAM,
            clocks.usb_clock,
            true,
            &mut ctx.device.RESETS,
        )));
        let usb_bus = ctx.local.usb_bus.as_ref().unwrap();
        rprintln!("init: created bus");

        let usb_class = UsbHidClassBuilder::new()
            .add_device(
                usbd_human_interface_device::device::keyboard::NKROBootKeyboardConfig::default(),
            )
            .build(usb_bus);
        rprintln!("init: created hid");

        let usb_dev = keyberon::new_device(usb_bus);
        rprintln!("init: created usb dev");

        unsafe {
            pac::NVIC::unmask(pac::Interrupt::USBCTRL_IRQ);
            pac::NVIC::unmask(pac::Interrupt::TIMER_IRQ_0);
        };

        let sio = Sio::new(ctx.device.SIO);
        let gpio0 = rp_pico::Pins::new(
            ctx.device.IO_BANK0,
            ctx.device.PADS_BANK0,
            sio.gpio_bank0,
            &mut ctx.device.RESETS,
        );
        // rp-pico hal, gpio23 = b_power_save
        let direct_pins = DirectPins1x1((gpio0.b_power_save.into_pull_down_input(),));
        rprintln!("init: created keyboard matrix");

        // Return resources and timer
        (
            Shared { usb_dev, usb_class },
            Local {
                debouncer: Debouncer::new(PressedKeys1x1::default(), PressedKeys1x1::default(), 5),
                direct_pins,
                layout: Layout::new(&LAYERS),
                alarm,
                watchdog,
            },
            init::Monotonics(),
        )
    }

    #[task(binds = USBCTRL_IRQ, priority = 2, shared = [usb_dev, usb_class])]
    fn usb_tx(c: usb_tx::Context) {
        let usb_tx::SharedResources { usb_dev, usb_class } = c.shared;
        (usb_dev, usb_class).lock(|mut ud, mut uc| usb_poll(&mut ud, &mut uc));
    }

    #[task(binds = TIMER_IRQ_0, priority = 1, shared = [usb_class], local = [direct_pins, debouncer, layout, alarm, watchdog])]
    fn tick(c: tick::Context) {
        c.local.alarm.clear_interrupt();
        c.local.alarm.schedule(1.millis()).unwrap();

        let pressed_keys: PressedKeys1x1 = c.local.direct_pins.get().unwrap();
        let events = c.local.debouncer.events(pressed_keys);

        for event in events {
            rprintln!("tick: debounced event: {:?}", event);
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
