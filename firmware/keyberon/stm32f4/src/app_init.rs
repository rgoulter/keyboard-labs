use fugit::{ExtU32, RateExtU32};
use hal::{
    otg_fs::UsbBusType,
    pac::TIM3,
    rcc::{Clocks, Rcc},
    timer::{CounterUs, Event, TimerExt},
};
use stm32f4xx_hal as hal;
use usb_device::bus::UsbBusAllocator;
use usb_device::device::{UsbDeviceBuilder, UsbVidPid};
use usbd_human_interface_device::usb_class::UsbHidClassBuilder;

use crate::common::{UsbClass, UsbDevice};

pub fn init_clocks(rcc: Rcc) -> Clocks {
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
        .add_device(usbd_human_interface_device::device::consumer::ConsumerControlConfig::default())
        .build(usb_bus);

    let usb_dev = UsbDeviceBuilder::new(usb_bus, UsbVidPid(vid, pid))
        .manufacturer(mfr)
        .product(product)
        .serial_number(env!("CARGO_PKG_VERSION"))
        .build();

    (usb_dev, usb_class)
}

pub fn init_timer(clocks: &Clocks, tim3: TIM3) -> CounterUs<TIM3> {
    let mut timer = tim3.counter_us(&clocks);
    timer.start(1.millis()).unwrap();
    timer.listen(Event::Update);
    timer
}
