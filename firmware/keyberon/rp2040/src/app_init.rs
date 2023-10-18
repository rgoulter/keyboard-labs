use rp2040_hal as hal;

use hal::pac;

use hal::clocks::ClocksManager;
use hal::timer;
use hal::timer::Alarm;
use hal::usb::UsbBus;

use rp_pico::XOSC_CRYSTAL_FREQ;

use fugit::ExtU32;

use usb_device::bus::UsbBusAllocator;
use usb_device::device::{UsbDeviceBuilder, UsbVidPid};

use usbd_human_interface_device::usb_class::UsbHidClassBuilder;

use crate::common::{UsbClass, UsbDevice};

pub fn init_clocks(
    watchdog: pac::WATCHDOG,
    xosc: pac::XOSC,
    clocks: pac::CLOCKS,
    pll_sys: pac::PLL_SYS,
    pll_usb: pac::PLL_USB,
    resets: &mut pac::RESETS,
) -> (hal::Watchdog, ClocksManager) {
    let mut watchdog = hal::Watchdog::new(watchdog);
    let clocks = hal::clocks::init_clocks_and_plls(
        XOSC_CRYSTAL_FREQ,
        xosc,
        clocks,
        pll_sys,
        pll_usb,
        resets,
        &mut watchdog,
    )
    .ok()
    .unwrap();
    (watchdog, clocks)
}

pub fn init_timer(
    pac_timer: pac::TIMER,
    resets: &mut pac::RESETS,
    clocks: &ClocksManager,
) -> (timer::Timer, timer::Alarm0) {
    let mut timer = timer::Timer::new(pac_timer, resets, &clocks);
    let mut alarm = timer.alarm_0().unwrap();
    alarm.enable_interrupt();
    alarm.schedule(1.millis()).unwrap();
    (timer, alarm)
}

pub fn init_usb_device(
    usb_bus: &'static UsbBusAllocator<UsbBus>,
    vid: u16,
    pid: u16,
    mfr: &'static str,
    product: &'static str,
) -> (UsbDevice, UsbClass) {
    let usb_class = UsbHidClassBuilder::new()
        .add_device(
            usbd_human_interface_device::device::keyboard::NKROBootKeyboardConfig::default(),
        )
        .add_device(
            usbd_human_interface_device::device::consumer::ConsumerControlConfig::default(),
        )
        .build(usb_bus);

    let usb_dev = UsbDeviceBuilder::new(usb_bus, UsbVidPid(vid, pid))
        .manufacturer(mfr)
        .product(product)
        .serial_number(env!("CARGO_PKG_VERSION"))
        .build();

    (usb_dev, usb_class)
}
