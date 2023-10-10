use stm32f4xx_hal::otg_fs::UsbBusType;

use frunk::HList;
use usbd_human_interface_device::device::keyboard::NKROBootKeyboard;
use usbd_human_interface_device::usb_class::UsbHidClass;

pub use keyboard_labs_keyberon::common::*;

pub type UsbClass = UsbHidClass<'static, UsbBusType, HList!(NKROBootKeyboard<'static, UsbBusType>)>;

pub type UsbDevice = usb_device::device::UsbDevice<'static, UsbBusType>;

pub type UsbSerial = usbd_serial::SerialPort<'static, UsbBusType>;
