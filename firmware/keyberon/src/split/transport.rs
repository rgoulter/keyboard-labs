use embedded_hal::serial::Read;
use embedded_hal::serial::Write;
use keyberon::chording::Chording;
use keyberon::debounce::Debouncer;
use keyberon::layout::Event;
use nb::block;
use stm32f4xx_hal::serial::{Rx, Tx};

// Messages for the RTIC task which manages the Keyberon layout.
#[derive(Debug)]
pub enum LayoutMessage {
    // Update the layout with this event.
    Event(Event),
    // Tick the layout (and write report to the USB class).
    Tick,
}

/// Deserialise a slice of bytes into a keyberon Event.
///
/// The serialisation format must be compatible with
/// the serialisation format in `ser`.
pub fn de(bytes: &[u8]) -> Result<Event, ()> {
    match *bytes {
        [b'P', i, j, b'\n'] => Ok(Event::Press(i, j)),
        [b'R', i, j, b'\n'] => Ok(Event::Release(i, j)),
        _ => Err(()),
    }
}

/// Serialise a keyberon event into an array of bytes.
///
/// The serialisation format must be compatible with
/// the serialisation format in `de`.
pub fn ser(e: Event) -> [u8; 4] {
    match e {
        Event::Press(i, j) => [b'P', i, j, b'\n'],
        Event::Release(i, j) => [b'R', i, j, b'\n'],
    }
}

pub fn receive_byte(buf: &mut [u8; 4], b: u8) -> Option<Event> {
    buf.rotate_left(1);
    buf[3] = b;

    if buf[3] == b'\n' {
        de(&buf[..]).ok()
    } else {
        None
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

pub fn event_transform_identity(e: Event) -> Event {
    e
}

pub fn transformed_keyboard_events<
    const COLS: usize,
    const ROWS: usize,
    const NUM_CHORDS: usize,
    E,
>(
    matrix: &mut impl crate::common::Matrix<COLS, ROWS, E>,
    debouncer: &mut Debouncer<[[bool; COLS]; ROWS]>,
    chording: &mut Chording<NUM_CHORDS>,
    event_transform: fn(Event) -> Event,
) -> heapless::Vec<Event, 8>
where
    E: core::fmt::Debug,
{
    let transformed_events = debouncer.events(matrix.get().unwrap()).map(event_transform);
    chording.tick(transformed_events.collect())
}
