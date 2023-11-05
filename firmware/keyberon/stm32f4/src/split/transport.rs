use embedded_hal::serial::Read;
use embedded_hal::serial::Write;
use hal::{
    pac::USART1,
    serial::{Rx, Tx},
};
use keyberon::layout::Event;
use nb::block;
use stm32f4xx_hal as hal;

use keyboard_labs_keyberon::split::transport::{receive_byte, ser};

pub struct TransportReader {
    pub buf: &'static mut [u8; 4],
    pub rx: Rx<USART1>,
}

pub struct TransportWriter {
    pub tx: Tx<USART1>,
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

pub fn split_read_event(buf: &mut [u8; 4], rx: &mut Rx<USART1>) -> Option<Event> {
    rx.read().ok().and_then(|b: u8| receive_byte(buf, b))
}

pub fn split_write_event(event: Event, tx: &mut Tx<USART1>) {
    for &b in &ser(event) {
        block!(tx.write(b)).unwrap();
    }
    block!(tx.flush()).unwrap();
}
