use hal::{
    gpio::gpiob,
    pac::USART1,
    rcc::Clocks,
    serial::config::Config,
    serial::{Event, Listen, Serial},
    time::U32Ext,
};
use stm32f4xx_hal as hal;

use crate::split::transport::{TransportReader, TransportWriter};

pub fn init_serial(
    clocks: &Clocks,
    pb6: gpiob::PB6,
    pb7: gpiob::PB7,
    usart1: USART1,
    buf: &'static mut [u8; 4],
) -> (TransportWriter, TransportReader) {
    let pins = (pb6.into_alternate(), pb7.into_alternate());
    let mut serial = Serial::new(
        usart1,
        pins,
        Config::default().baudrate(9_600.bps()),
        &clocks,
    )
    .unwrap();
    serial.listen(Event::Rxne);

    let (tx, rx) = serial.split();
    (TransportWriter { tx }, TransportReader { buf, rx })
}
