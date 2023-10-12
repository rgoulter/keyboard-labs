use rp2040_hal::usb::UsbBus;

use frunk::HList;
use usbd_human_interface_device::device::keyboard::NKROBootKeyboard;
use usbd_human_interface_device::usb_class::UsbHidClass;

pub use keyboard_labs_keyberon::common::*;

pub type UsbClass = UsbHidClass<'static, UsbBus, HList!(NKROBootKeyboard<'static, UsbBus>)>;

pub type UsbDevice = usb_device::device::UsbDevice<'static, UsbBus>;

pub type UsbSerial = usbd_serial::SerialPort<'static, UsbBus>;
