use fugit::ExtU32;
use fugit::RateExtU32;
use stm32f4xx_hal::otg_fs::UsbBusType;
use stm32f4xx_hal::timer::TimerExt;
use stm32f4xx_hal::{pac, timer};
use usb_device::bus::UsbBusAllocator;
use usb_device::device::{UsbDeviceBuilder, UsbVidPid};
use usbd_human_interface_device::usb_class::UsbHidClassBuilder;

use crate::common::{UsbClass, UsbDevice};
pub fn init_clocks(rcc: stm32f4xx_hal::rcc::Rcc) -> stm32f4xx_hal::rcc::Clocks {
    rcc.cfgr
        .use_hse(25.MHz())
        .sysclk(84.MHz())
        .require_pll48clk()
        .freeze()
}

pub fn init_usb_device(
    usb_bus: &'static UsbBusAllocator<UsbBusType>,
    vid: u16,
    pid: u16,
    mfr: &'static str,
    product: &'static str,
) -> (UsbDevice, UsbClass) {
    let usb_class = UsbHidClassBuilder::new()
        .add_device(
            usbd_human_interface_device::device::keyboard::NKROBootKeyboardConfig::default(),
        )
        .build(usb_bus);

    let usb_dev = UsbDeviceBuilder::new(usb_bus, UsbVidPid(vid, pid))
        .manufacturer(mfr)
        .product(product)
        .serial_number(env!("CARGO_PKG_VERSION"))
        .build();

    (usb_dev, usb_class)
}

pub fn init_timer(
    clocks: &stm32f4xx_hal::rcc::Clocks,
    tim3: pac::TIM3,
) -> timer::CounterUs<pac::TIM3> {
    let mut timer = tim3.counter_us(&clocks);
    timer.start(1.millis()).unwrap();
    timer.listen(timer::Event::Update);
    timer
}
