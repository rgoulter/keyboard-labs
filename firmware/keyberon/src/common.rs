use usb_device::UsbError;

use frunk::hlist::Selector;
use frunk::HList;
use usb_device::bus::UsbBus;
use usb_device::device::UsbDevice;
use usbd_human_interface_device::device::consumer::ConsumerControl;
use usbd_human_interface_device::device::keyboard::NKROBootKeyboard;
use usbd_human_interface_device::device::DeviceHList;
use usbd_human_interface_device::usb_class::UsbHidClass;

pub const VID: u16 = 0xcafe;
pub const MANUFACTURER: &str = "Richard Goulter's Keyboard Labs";

pub type UsbClass<B> =
    UsbHidClass<'static, B, HList!(ConsumerControl<'static, B>, NKROBootKeyboard<'static, B>,)>;

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
