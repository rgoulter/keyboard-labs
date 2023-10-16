use embedded_hal::serial::Read;
use embedded_hal::serial::Write;
use keyberon::layout::Event;
use nb::block;
use stm32f4xx_hal::serial::{Rx, Tx};

use keyboard_labs_keyberon::split::transport::{receive_byte, ser};

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
