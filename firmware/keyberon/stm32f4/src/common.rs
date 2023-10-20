use stm32f4xx_hal::otg_fs::UsbBusType;

pub use keyboard_labs_keyberon::common::*;

pub type UsbClass = keyboard_labs_keyberon::common::UsbClass<UsbBusType>;

pub type UsbDevice = usb_device::device::UsbDevice<'static, UsbBusType>;

pub type UsbSerial = usbd_serial::SerialPort<'static, UsbBusType>;
