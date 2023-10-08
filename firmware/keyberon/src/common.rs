use stm32f4xx_hal::otg_fs::UsbBusType;
use keyberon::layout::Event;
use usb_device::class::UsbClass as _;

use frunk::HList;
use usbd_human_interface_device::device::keyboard::NKROBootKeyboard;
use usbd_human_interface_device::usb_class::UsbHidClass;

pub type UsbClass = UsbHidClass<'static, UsbBusType, HList!(NKROBootKeyboard<'static, UsbBusType>)>;

pub type UsbDevice = usb_device::device::UsbDevice<'static, UsbBusType>;

pub type UsbSerial = usbd_serial::SerialPort<'static, UsbBusType>;

pub fn usb_poll(
    usb_dev: &mut UsbDevice,
    keyboard: &mut UsbClass,
) {
    if usb_dev.poll(&mut [keyboard]) {
        keyboard.poll();
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
