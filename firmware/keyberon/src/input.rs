use core::convert::Infallible;
use core::marker::PhantomData;
use embedded_hal::digital::v2::InputPin;
use keyberon::chording::Chording;
use keyberon::debounce::Debouncer;
use keyberon::layout::Event;
use usb_device::bus::UsbBus;
use usb_device::UsbError;
use usbd_human_interface_device::device::consumer::{ConsumerControl, MultipleConsumerReport};
use usbd_human_interface_device::device::keyboard::NKROBootKeyboard;
use usbd_human_interface_device::page;
use usbd_human_interface_device::UsbHidError;

use crate::common;
use crate::layouts::common::CustomAction;

pub type PressedKeys<const COLS: usize, const ROWS: usize> = [[bool; COLS]; ROWS];

pub type PressedKeys1x1 = PressedKeys<1, 1>;
pub type PressedKeys5x4 = PressedKeys<5, 4>;
pub type PressedKeys12x4 = PressedKeys<12, 4>;
pub type PressedKeys12x5 = PressedKeys<12, 5>;

// R for 'matrix get result type',
// E for 'error of matrix get result type'.
pub trait MatrixScanner<const COLS: usize, const ROWS: usize, E = Infallible> {
    fn get(&mut self) -> Result<[[bool; COLS]; ROWS], E>;
}

/// The keyboard "frontend", manages the keyboard from the hardware matrix
/// through to keyboard events (presses/releases of coordinates on a keyboard layout).
///
/// This takes care of scanning the keyboard matrix, debouncing, and handling matrix chords.
pub struct Keyboard<
    const COLS: usize,
    const ROWS: usize,
    const NUM_CHORDS: usize,
    M: MatrixScanner<COLS, ROWS>,
> {
    pub matrix: M,
    pub debouncer: Debouncer<PressedKeys<COLS, ROWS>>,
    pub chording: Chording<NUM_CHORDS>,
}

impl<
        const COLS: usize,
        const ROWS: usize,
        const NUM_CHORDS: usize,
        M: MatrixScanner<COLS, ROWS>,
    > Keyboard<COLS, ROWS, NUM_CHORDS, M>
{
    pub fn new(
        matrix: M,
        debouncer: Debouncer<PressedKeys<COLS, ROWS>>,
        chording: Chording<NUM_CHORDS>,
    ) -> Self {
        Self {
            matrix,
            debouncer,
            chording,
        }
    }

    pub fn events(&mut self) -> heapless::Vec<Event, 8> {
        let key_presses = self.matrix.get().unwrap();
        let debounced_events = self.debouncer.events(key_presses).collect();
        self.chording.tick(debounced_events)
    }
}

/// Simplified interface of the keyberon's Layout.
///
/// I: Iteratable for keycodes.
/// T: Custom action type
/// K: Keycode type
pub trait LayoutEngine<T, K> {
    type KeycodeIterator<'a>: IntoIterator<Item = K>;

    /// Register a key event.
    fn event(&mut self, event: keyberon::layout::Event);

    /// Iterates on the key codes of the current state.
    fn keycodes<'a>(&self) -> Self::KeycodeIterator<'a>;

    /// A time event.
    ///
    /// This method must be called regularly, typically every millisecond.
    ///
    /// Returns the corresponding `CustomEvent`, allowing to manage
    /// custom actions thanks to the `Action::Custom` variant.
    fn tick(&mut self) -> keyberon::layout::CustomEvent<T>;
}

// C: number of columns
// R: number of rows
// L: number of layers
// T: custom action type
// K: keycode type
impl<const C: usize, const R: usize, const L: usize, T: 'static, K: 'static + Copy>
    LayoutEngine<T, K> for keyberon::layout::Layout<C, R, L, T, K>
{
    type KeycodeIterator<'a> = heapless::Vec<K, 8>;

    fn event(&mut self, event: keyberon::layout::Event) {
        self.event(event);
    }

    fn keycodes<'a>(&self) -> Self::KeycodeIterator<'a> {
        // keyberon's keycodes() has signature which returns `impl Iterator<Item = K>`;
        // Currently, can't use `impl Trait` in associated types,
        // so collect the keycodes into a Vec.
        self.keycodes().collect()
    }

    fn tick(&mut self) -> keyberon::layout::CustomEvent<T> {
        self.tick()
    }
}

pub trait HIDReporter<K, C, KE, CE> {
    fn write_keyboard_report(&mut self, report: impl IntoIterator<Item = K>) -> Result<(), KE>;

    fn write_consumer_report(&mut self, report: impl IntoIterator<Item = C>) -> Result<(), CE>;
}

impl<B> HIDReporter<page::Keyboard, page::Consumer, UsbHidError, UsbError> for common::UsbClass<B>
where
    B: UsbBus,
{
    fn write_keyboard_report(
        &mut self,
        iter: impl IntoIterator<Item = page::Keyboard>,
    ) -> Result<(), UsbHidError> {
        self.device::<NKROBootKeyboard<'_, _>, _>()
            .write_report(iter)
    }

    fn write_consumer_report(
        &mut self,
        iter: impl IntoIterator<Item = page::Consumer>,
    ) -> Result<(), UsbError> {
        let codes: [page::Consumer; 4] = iter
            .into_iter()
            .chain(core::iter::repeat(page::Consumer::Unassigned))
            .take(4)
            .collect::<heapless::Vec<_, 4>>()
            .into_array()
            .unwrap();
        let report = MultipleConsumerReport { codes };
        self.device::<ConsumerControl<'_, _>, _>()
            .write_report(&report)
            .map(|_| ())
    }
}

/// The keyboard "backend", manages the keyboard from the events received
/// (presses/releases of coordinates on a keyboard layout).
/// through to listing HID scancodes to report using HIDs.
///
/// L: The layout engine
pub struct KeyboardBackend<T, K, C, L: LayoutEngine<T, K>> {
    layout: L,
    previous_consumer_codes: heapless::Vec<C, 4>,
    keyboard_codes: heapless::Vec<K, 8>,
    consumer_codes: heapless::Vec<C, 4>,
    marker: PhantomData<T>,
}

impl<L: LayoutEngine<CustomAction, page::Keyboard>>
    KeyboardBackend<CustomAction, page::Keyboard, page::Consumer, L>
{
    pub fn new(layout: L) -> Self {
        Self {
            layout,
            previous_consumer_codes: heapless::Vec::new(),
            keyboard_codes: heapless::Vec::new(),
            consumer_codes: heapless::Vec::new(),
            marker: PhantomData,
        }
    }

    /// Register a key event.
    pub fn event(&mut self, event: keyberon::layout::Event) {
        self.layout.event(event);
    }

    /// A time event.
    ///
    /// This method must be called regularly, typically every millisecond.
    pub fn tick(&mut self) {
        let keycodes = self.layout.keycodes().into_iter().collect();
        let mut consumer_codes: heapless::Vec<page::Consumer, 4> = heapless::Vec::new();

        let custom_event = self.layout.tick();
        match custom_event {
            keyberon::layout::CustomEvent::Press(custom_action) => match custom_action {
                crate::layouts::common::CustomAction::ConsumerA(consumer_code) => {
                    consumer_codes.push(consumer_code.clone()).unwrap();
                }
            },
            _ => {}
        }

        self.keyboard_codes = keycodes;
        self.consumer_codes = consumer_codes;
    }

    pub fn write_reports<KE, CE, R>(&mut self, hid_reporter: &mut R)
    where
        KE: core::fmt::Debug,
        CE: core::fmt::Debug,
        R: HIDReporter<page::Keyboard, page::Consumer, KE, CE>,
    {
        let _ = hid_reporter.write_keyboard_report(self.keyboard_codes.clone());

        if self.consumer_codes != self.previous_consumer_codes {
            if let Ok(_) = hid_reporter.write_consumer_report(self.consumer_codes.clone()) {
                self.previous_consumer_codes = self.consumer_codes.clone();
            }
        }
    }
}

pub fn row5_is_low<P>((a, b, c, d, e): &(P, P, P, P, P)) -> [bool; 5]
where
    P: InputPin<Error = Infallible>,
{
    [
        a.is_low().unwrap(),
        b.is_low().unwrap(),
        c.is_low().unwrap(),
        d.is_low().unwrap(),
        e.is_low().unwrap(),
    ]
}

pub fn row3_is_low_lhs<P>((a, b, c): &(P, P, P)) -> [bool; 5]
where
    P: InputPin<Error = Infallible>,
{
    [
        false,
        false,
        a.is_low().unwrap(),
        b.is_low().unwrap(),
        c.is_low().unwrap(),
    ]
}

pub fn row3_is_low_rhs<P>((a, b, c): &(P, P, P)) -> [bool; 5]
where
    P: InputPin<Error = Infallible>,
{
    [
        a.is_low().unwrap(),
        b.is_low().unwrap(),
        c.is_low().unwrap(),
        false,
        false,
    ]
}

pub fn row5_flipped<P>((a, b, c, d, e): (P, P, P, P, P)) -> (P, P, P, P, P) {
    (e, d, c, b, a)
}

pub fn row3_flipped<P>((a, b, c): (P, P, P)) -> (P, P, P) {
    (c, b, a)
}
