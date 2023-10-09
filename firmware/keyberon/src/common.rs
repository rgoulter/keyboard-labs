use stm32f4xx_hal::otg_fs::UsbBusType;
use stm32f4xx_hal::prelude::*;
use stm32f4xx_hal::serial::Rx;
use keyberon::layout::Event;
use usb_device::prelude::*;

use frunk::HList;
use usbd_human_interface_device::device::keyboard::NKROBootKeyboard;
use usbd_human_interface_device::page::Keyboard;
use usbd_human_interface_device::usb_class::UsbHidClass;
use usbd_human_interface_device::UsbHidError;

pub type UsbClass = UsbHidClass<'static, UsbBusType, HList!(NKROBootKeyboard<'static, UsbBusType>)>;

pub type UsbDevice = usb_device::device::UsbDevice<'static, UsbBusType>;

pub type UsbSerial = usbd_serial::SerialPort<'static, UsbBusType>;

// Messages for the RTIC task which manages the Keyberon layout.
#[derive(Debug)]
pub enum LayoutMessage {
    // Update the layout with this event.
    Event(Event),
    // Tick the layout (and write report to the USB class).
    Tick,
}

pub fn usb_poll(
    usb_dev: &mut UsbDevice,
    keyboard: &mut UsbClass,
) {
    if usb_dev.poll(&mut [keyboard]) {
        let interface = keyboard.device();
        match interface.read_report() {
            Err(UsbError::WouldBlock) => {}
            Err(e) => {
                core::panic!("Failed to read keyboard report: {:?}", e)
            }
            Ok(_leds) => {},
        }
    }
}

pub fn send_report(iter: impl Iterator<Item = Keyboard>, usb_class: &mut UsbClass) {
    match usb_class.device().write_report(iter) {
        Err(UsbHidError::WouldBlock) => {}
        Err(UsbHidError::Duplicate) => {}
        Ok(_) => {}
        Err(e) => {
            core::panic!("Failed to write keyboard report: {:?}", e)
        }
    }
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

pub fn split_read_event(buf: &mut [u8; 4], rx: &mut Rx<stm32f4xx_hal::pac::USART1>) -> Option<Event> {
    rx.read().ok().and_then(|b: u8| receive_byte(buf, b))
}
