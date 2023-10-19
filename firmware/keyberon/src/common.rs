use usb_device::UsbError;

use frunk::hlist::Selector;
use usb_device::bus::UsbBus;
use usb_device::device::UsbDevice;
use usbd_human_interface_device::device::keyboard::NKROBootKeyboard;
use usbd_human_interface_device::device::DeviceHList;
use usbd_human_interface_device::page::Keyboard;
use usbd_human_interface_device::usb_class::UsbHidClass;
use usbd_human_interface_device::UsbHidError;

pub const VID: u16 = 0xcafe;
pub const MANUFACTURER: &'static str = "Richard Goulter's Keyboard Labs";

pub fn usb_poll<B, D, Index>(
    usb_dev: &mut UsbDevice<'static, B>,
    keyboard: &mut UsbHidClass<'static, B, D>,
) where
    B: UsbBus,
    D: DeviceHList<'static> + Selector<NKROBootKeyboard<'static, B>, Index>,
{
    if usb_dev.poll(&mut [keyboard]) {
        let interface = keyboard.device::<NKROBootKeyboard<'static, B>, _>();
        match interface.read_report() {
            Err(UsbError::WouldBlock) => {}
            Err(e) => {
                core::panic!("Failed to read keyboard report: {:?}", e)
            }
            Ok(_leds) => {}
        }
    }
}

pub fn send_report<B, D, Index>(
    iter: impl Iterator<Item = Keyboard>,
    usb_class: &mut UsbHidClass<'static, B, D>,
) where
    B: UsbBus,
    D: DeviceHList<'static> + Selector<NKROBootKeyboard<'static, B>, Index>,
{
    match usb_class.device().write_report(iter) {
        Err(UsbHidError::WouldBlock) => {}
        Err(UsbHidError::Duplicate) => {}
        Ok(_) => {}
        Err(e) => {
            core::panic!("Failed to write keyboard report: {:?}", e)
        }
    }
}
