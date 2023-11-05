use rp2040_hal as hal;
use hal::usb::UsbBus;

pub use keyboard_labs_keyberon::common::*;

pub type UsbClass = keyboard_labs_keyberon::common::UsbClass<UsbBus>;

pub type UsbDevice = usb_device::device::UsbDevice<'static, UsbBus>;

pub type UsbSerial = usbd_serial::SerialPort<'static, UsbBus>;
