use keyberon::layout::Event;

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
#[allow(clippy::result_unit_err)]
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
