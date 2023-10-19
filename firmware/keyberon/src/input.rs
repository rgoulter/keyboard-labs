use core::convert::Infallible;
use core::marker::PhantomData;
use embedded_hal::digital::v2::InputPin;
use keyberon::chording::Chording;
use keyberon::debounce::Debouncer;
use keyberon::layout::Event;

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
impl<
    const C: usize, const R: usize, const L: usize, T: 'static, K: 'static + Copy
> LayoutEngine<T, K> for keyberon::layout::Layout<C, R, L, T, K> {
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

/// The keyboard "backend", manages the keyboard from the events received
/// (presses/releases of coordinates on a keyboard layout).
/// through to listing HID scancodes to report using HIDs.
///
/// L: The layout engine
pub struct KeyboardBackend<T, K, L: LayoutEngine<T, K>>
{
    pub layout: L,
    // compiler complains if we don't use T, K.
    custom_action_type: PhantomData<T>,
    keycode_type: PhantomData<K>,
}

impl<T: 'static, K, L: LayoutEngine<T, K>> KeyboardBackend<T, K, L> {
    pub fn new(layout: L) -> Self {
        Self {
            layout,
            custom_action_type: PhantomData,
            keycode_type: PhantomData,
        }
    }

    /// Register a key event.
    pub fn event(&mut self, event: keyberon::layout::Event) {
        self.layout.event(event);
    }

    /// Iterates on the key codes of the current state.
    pub fn hid_keyboard_keycodes<'a>(&self) -> L::KeycodeIterator<'a> {
        self.layout.keycodes()
    }

    /// A time event.
    ///
    /// This method must be called regularly, typically every millisecond.
    pub fn tick(&mut self) {
        let custom_event = self.layout.tick();
        match custom_event {
            _ => ()
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
