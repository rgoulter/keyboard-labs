use embedded_hal::serial::Read;
use embedded_hal::serial::Write;
use keyberon::layout::Event;
use nb::block;
use stm32f4xx_hal::serial::{Rx, Tx};

use keyboard_labs_keyberon::split::transport::{receive_byte, ser};

pub struct TransportReader {
    pub buf: &'static mut [u8; 4],
    pub rx: Rx<stm32f4xx_hal::pac::USART1>,
}

pub struct TransportWriter {
    pub tx: Tx<stm32f4xx_hal::pac::USART1>,
}

impl TransportReader {
    pub fn read(&mut self) -> Option<Event> {
        self.rx
            .read()
            .ok()
            .and_then(|b: u8| receive_byte(&mut self.buf, b))
    }
}

impl TransportWriter {
    pub fn write(&mut self, event: Event) {
        for &b in &ser(event) {
            block!(self.tx.write(b)).unwrap();
        }
        block!(self.tx.flush()).unwrap();
    }
}

pub fn split_read_event(
    buf: &mut [u8; 4],
    rx: &mut Rx<stm32f4xx_hal::pac::USART1>,
) -> Option<Event> {
    rx.read().ok().and_then(|b: u8| receive_byte(buf, b))
}

pub fn split_write_event(event: Event, tx: &mut Tx<stm32f4xx_hal::pac::USART1>) {
    for &b in &ser(event) {
        block!(tx.write(b)).unwrap();
    }
    block!(tx.flush()).unwrap();
}
