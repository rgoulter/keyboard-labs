use core::convert::Infallible;
use keyberon::chording::Chording;
use keyberon::debounce::Debouncer;
use keyberon::layout::Event;
use stm32f4xx_hal::otg_fs::UsbBusType;
use usb_device::UsbError;

use frunk::HList;
use usbd_human_interface_device::device::keyboard::NKROBootKeyboard;
use usbd_human_interface_device::page::Keyboard;
use usbd_human_interface_device::usb_class::UsbHidClass;
use usbd_human_interface_device::UsbHidError;

pub type UsbClass = UsbHidClass<'static, UsbBusType, HList!(NKROBootKeyboard<'static, UsbBusType>)>;

pub type UsbDevice = usb_device::device::UsbDevice<'static, UsbBusType>;

pub type UsbSerial = usbd_serial::SerialPort<'static, UsbBusType>;

pub const VID: u16 = 0xcafe;
pub const MANUFACTURER: &'static str = "Richard Goulter's Keyboard Labs";

pub fn usb_poll(usb_dev: &mut UsbDevice, keyboard: &mut UsbClass) {
    if usb_dev.poll(&mut [keyboard]) {
        let interface = keyboard.device();
        match interface.read_report() {
            Err(UsbError::WouldBlock) => {}
            Err(e) => {
                core::panic!("Failed to read keyboard report: {:?}", e)
            }
            Ok(_leds) => {}
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

// R for 'matrix get result type',
// E for 'error of matrix get result type'.
pub trait Matrix<const COLS: usize, const ROWS: usize, E = Infallible> {
    fn get(&mut self) -> Result<[[bool; COLS]; ROWS], E>;
}

pub fn keyboard_events<const COLS: usize, const ROWS: usize, const NUM_CHORDS: usize, E>(
    matrix: &mut impl Matrix<COLS, ROWS, E>,
    debouncer: &mut Debouncer<[[bool; COLS]; ROWS]>,
    chording: &mut Chording<NUM_CHORDS>,
) -> heapless::Vec<Event, 8>
where
    E: core::fmt::Debug,
{
    let debounced_events = debouncer.events(matrix.get().unwrap());
    chording.tick(debounced_events.collect())
}
