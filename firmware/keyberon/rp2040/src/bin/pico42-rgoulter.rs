#![no_std]
#![no_main]

#[rtic::app(
    device = rp_pico::hal::pac,
)]
mod app {
    use panic_halt as _;

    use keyboard_labs_keyberon_rp2040::app_prelude::*;

    // use embedded_hal::blocking::delay::DelayUs;
    use keyboard_labs_keyberon::layouts::split_3x5_3::rgoulter::matrix4x12::{
        Layout, CHORDS, COLS, LAYERS, NUM_CHORDS, ROWS,
    };
    use keyboard_labs_keyberon::matrix::Matrix as DelayedMatrix;
    use keyboard_labs_keyberon_rp2040::pinout::pykey40::cols_and_rows_for_peripherals;

    #[shared]
    struct Shared {
        usb_dev: UsbDevice,
        usb_class: UsbClass,
    }

    #[local]
    struct Local {
        alarm: timer::Alarm0,
        matrix: DelayedMatrix<Input, Output, COLS, ROWS, timer::Timer>,
        debouncer: Debouncer<[[bool; COLS]; ROWS]>,
        chording: Chording<NUM_CHORDS>,
        layout: Layout,
    }

    #[init(local=[
        usb_bus: Option<UsbBusAllocator<UsbBus>> = None
    ])]
    fn init(mut ctx: init::Context) -> (Shared, Local, init::Monotonics) {
        let (mut _watchdog, clocks) = app_init::init_clocks(
            ctx.device.WATCHDOG,
            ctx.device.XOSC,
            ctx.device.CLOCKS,
            ctx.device.PLL_SYS,
            ctx.device.PLL_USB,
            &mut ctx.device.RESETS,
        );

        let (timer, alarm) =
            app_init::init_timer(ctx.device.TIMER, &mut ctx.device.RESETS, &clocks);

        // Set up the USB driver
        *ctx.local.usb_bus = Some(UsbBusAllocator::new(hal::usb::UsbBus::new(
            ctx.device.USBCTRL_REGS,
            ctx.device.USBCTRL_DPRAM,
            clocks.usb_clock,
            true,
            &mut ctx.device.RESETS,
        )));
        let usb_bus = ctx.local.usb_bus.as_ref().unwrap();

        let (usb_dev, usb_class) =
            app_init::init_usb_device(usb_bus, VID, 0x0005, MANUFACTURER, "Pico42 Keyboard");

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
        let rp_pico::Pins {
            gpio0,
            gpio1,
            gpio2,
            gpio3,
            gpio4,
            gpio5,
            gpio6,
            gpio7,
            gpio8,
            gpio9,
            gpio10,
            gpio11,
            gpio14,
            gpio15,
            gpio16,
            gpio17,
            ..
        } = gpio0;
        let (cols, rows) = cols_and_rows_for_peripherals(
            gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6, gpio7, gpio8, gpio9, gpio10, gpio11,
            gpio14, gpio15, gpio16, gpio17,
        );
        let matrix = DelayedMatrix::new(cols, rows, timer, 5, 5).unwrap();

        (
            Shared { usb_dev, usb_class },
            Local {
                alarm,
                matrix,
                debouncer: Debouncer::new([[false; COLS]; ROWS], [[false; COLS]; ROWS], 25),
                chording: Chording::new(&CHORDS),
                layout: Layout::new(&LAYERS),
            },
            init::Monotonics(),
        )
    }

    #[task(binds = USBCTRL_IRQ, priority = 2, shared = [usb_dev, usb_class])]
    fn usb_tx(c: usb_tx::Context) {
        let usb_tx::SharedResources { usb_dev, usb_class } = c.shared;
        (usb_dev, usb_class).lock(|mut ud, mut uc| usb_poll(&mut ud, &mut uc));
    }

    #[task(binds = TIMER_IRQ_0, priority = 1, shared = [usb_class], local = [matrix, debouncer, chording, layout, alarm])]
    fn tick(c: tick::Context) {
        let tick::SharedResources { mut usb_class } = c.shared;
        let tick::LocalResources {
            alarm,
            matrix,
            debouncer,
            chording,
            layout,
        } = c.local;

        alarm.clear_interrupt();
        alarm.schedule(1.millis()).unwrap();

        for event in keyboard_events(matrix, debouncer, chording) {
            layout.event(event);
        }
        match layout.tick() {
            _ => (),
        }

        usb_class.lock(|mut k| send_report(layout.keycodes(), &mut k));
    }
}