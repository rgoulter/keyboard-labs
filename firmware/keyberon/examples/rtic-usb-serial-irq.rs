#![no_main]
#![no_std]

// set the panic handler
use panic_halt as _;

use rtic::app;

use stm32f4xx_hal::otg_fs::{UsbBus, USB};
use stm32f4xx_hal::prelude::*;
use stm32f4xx_hal::pac::Interrupt;
use usb_device::class_prelude::UsbBusAllocator;
use usb_device::prelude::*;
use usbd_serial::SerialPort;

#[app(device = stm32f4xx_hal::pac, peripherals = true)]
const APP: () = {
    struct Resources {
        serial: SerialPort<'static, UsbBus<USB>>,
        usb_dev: UsbDevice<'static, UsbBus<USB>>,
    }

    #[init]
    fn init(c: init::Context) -> init::LateResources {
        static mut EP_MEMORY: [u32; 1024] = [0; 1024];
        static mut USB_BUS: Option<UsbBusAllocator<stm32f4xx_hal::otg_fs::UsbBusType>> = None;

        let rcc = c.device.RCC.constrain();
        let clocks = rcc
            .cfgr
            .use_hse(25.MHz())
            .sysclk(84.MHz())
            .require_pll48clk()
            .freeze();
        let gpioa = c.device.GPIOA.split();

        let usb = USB::new(
            (c.device.OTG_FS_GLOBAL, c.device.OTG_FS_DEVICE, c.device.OTG_FS_PWRCLK),
            (gpioa.pa11, gpioa.pa12),
            &clocks,
        );

        *USB_BUS = Some(stm32f4xx_hal::otg_fs::UsbBusType::new(usb, EP_MEMORY));
        let usb_bus = USB_BUS.as_ref().unwrap();

        let serial = SerialPort::new(usb_bus);

        let usb_dev =
            UsbDeviceBuilder::new(usb_bus, UsbVidPid(0x16c0, 0x27dd))
                .manufacturer("Fake company")
                .product("Serial port")
                .serial_number("TEST")
                .device_class(usbd_serial::USB_CLASS_CDC)
                .build();

        unsafe {
            cortex_m::peripheral::NVIC::unmask(Interrupt::OTG_FS);
        }

        init::LateResources {
            serial,
            usb_dev,
        }
    }

    #[task(binds = OTG_FS, priority = 2, resources = [usb_dev, serial])]
    fn usb_tx(c: usb_tx::Context) {
        if c.resources.usb_dev.poll(&mut [c.resources.serial]) {
            let mut buf = [0u8; 64];

            match c.resources.serial.read(&mut buf) {
                Ok(count) if count > 0 => {
                    // Echo back in upper case
                    for c in buf[0..count].iter_mut() {
                        if 0x61 <= *c && *c <= 0x7a {
                            *c &= !0x20;
                        }
                    }

                    let mut write_offset = 0;
                    while write_offset < count {
                        match c.resources.serial.write(&buf[write_offset..count]) {
                            Ok(len) if len > 0 => {
                                write_offset += len;
                            }
                            _ => {}
                        }
                    }
                }
                _ => {}
            }
        }
    }
};
