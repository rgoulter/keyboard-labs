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
    use rp2040_monotonic::{fugit::Duration, ExtU64, Rp2040Monotonic};
    use rp_pico::hal;
    use rp_pico::hal::{clocks, gpio, pac, sio::Sio, usb::UsbBus, watchdog::Watchdog};
    use rp_pico::XOSC_CRYSTAL_FREQ;

    use embedded_hal::digital::v2::{OutputPin, ToggleableOutputPin};

    use usb_device::bus::UsbBusAllocator;
    use usb_device::prelude::*;
    use usbd_serial::SerialPort;

    #[shared]
    struct Shared {}

    #[local]
    struct Local {
        usb_dev: UsbDevice<'static, UsbBus>,
        serial: SerialPort<'static, UsbBus>,
    }

    #[init(local=[
        usb_bus: Option<UsbBusAllocator<UsbBus>> = None
    ])]
    fn init(mut ctx: init::Context) -> (Shared, Local, init::Monotonics) {
        // Configure the clocks, watchdog - The default is to generate a 125 MHz system clock
        let mut watchdog = Watchdog::new(ctx.device.WATCHDOG);
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

        // Set up the USB driver
        *ctx.local.usb_bus = Some(UsbBusAllocator::new(hal::usb::UsbBus::new(
            ctx.device.USBCTRL_REGS,
            ctx.device.USBCTRL_DPRAM,
            clocks.usb_clock,
            true,
            &mut ctx.device.RESETS,
        )));
        rprintln!("init: allocated bus");
        let usb_bus = ctx.local.usb_bus.as_ref().unwrap();
        rprintln!("init: got usb_bus ref");

        let serial = SerialPort::new(usb_bus);
        rprintln!("init: created serial");

        let usb_dev = UsbDeviceBuilder::new(usb_bus, UsbVidPid(0x16c0, 0x27dd))
            .manufacturer("Fake company")
            .product("Serial port")
            .serial_number("TEST")
            .device_class(usbd_serial::USB_CLASS_CDC)
            .build();
        rprintln!("init: created dev");

        unsafe {
            pac::NVIC::unmask(rp2040_hal::pac::Interrupt::USBCTRL_IRQ);
        };

        // Return resources and timer
        (Shared {}, Local { usb_dev, serial }, init::Monotonics())
    }

    #[task(binds = USBCTRL_IRQ, priority = 2, local = [usb_dev, serial])]
    fn usb_tx(c: usb_tx::Context) {
        if c.local.usb_dev.poll(&mut [c.local.serial]) {
            let mut buf = [0u8; 64];
            match c.local.serial.read(&mut buf) {
                Err(_e) => {
                    // Do nothing
                }
                Ok(0) => {
                    // Do nothing
                }
                Ok(count) => {
                    // Convert to upper case
                    buf.iter_mut().take(count).for_each(|b| {
                        b.make_ascii_uppercase();
                    });

                    // Send back to the host
                    let mut wr_ptr = &buf[..count];
                    while !wr_ptr.is_empty() {
                        let _ = c.local.serial.write(wr_ptr).map(|len| {
                            wr_ptr = &wr_ptr[len..];
                        });
                    }
                }
            }
        }
    }
}
