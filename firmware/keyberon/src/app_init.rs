use fugit::ExtU32;
use fugit::RateExtU32;
use usbd_human_interface_device::usb_class::UsbHidClassBuilder;
use usb_device::bus::{UsbBusAllocator};
use stm32f4xx_hal::otg_fs::UsbBusType;
use stm32f4xx_hal::gpio::gpiob;
use stm32f4xx_hal::serial::Listen;
use stm32f4xx_hal::serial::config::Config;
use stm32f4xx_hal::time::U32Ext;
use stm32f4xx_hal::timer::TimerExt;
use stm32f4xx_hal::{pac, serial, timer};

use crate::common::{UsbClass, UsbDevice};
pub fn init_clocks(rcc: stm32f4xx_hal::rcc::Rcc) -> stm32f4xx_hal::rcc::Clocks {
    rcc
        .cfgr
        .use_hse(25.MHz())
        .sysclk(84.MHz())
        .require_pll48clk()
        .freeze()
}

pub fn init_usb_device(usb_bus: &'static UsbBusAllocator<UsbBusType>) -> (UsbDevice, UsbClass) {
    let usb_class = UsbHidClassBuilder::new()
        .add_device(
            usbd_human_interface_device::device::keyboard::NKROBootKeyboardConfig::default(),
        )
        .build(usb_bus);

    let usb_dev = keyberon::new_device(usb_bus);

    (usb_dev, usb_class)
}

pub fn init_timer(clocks: &stm32f4xx_hal::rcc::Clocks, tim3: pac::TIM3) -> timer::CounterUs<pac::TIM3> {
    let mut timer = tim3.counter_us(&clocks);
    timer.start(1.millis()).unwrap();
    timer.listen(timer::Event::Update);
    timer
}

pub fn init_serial(
    clocks: &stm32f4xx_hal::rcc::Clocks,
    pb6: gpiob::PB6,
    pb7: gpiob::PB7,
    usart1: pac::USART1,
) -> (serial::Tx<stm32f4xx_hal::pac::USART1>, serial::Rx<stm32f4xx_hal::pac::USART1>) {
        let pins = (
            pb6.into_alternate(),
            pb7.into_alternate(),
        );
        let mut serial = serial::Serial::new(
            usart1,
            pins,
            Config::default().baudrate(9_600.bps()),
            &clocks,
        )
        .unwrap();
        serial.listen(serial::Event::Rxne);
        serial.split()
}
