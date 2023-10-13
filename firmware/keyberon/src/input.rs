use core::convert::Infallible;
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

pub fn keyboard_events<const COLS: usize, const ROWS: usize, const NUM_CHORDS: usize, E>(
    matrix: &mut impl MatrixScanner<COLS, ROWS, E>,
    debouncer: &mut Debouncer<[[bool; COLS]; ROWS]>,
    chording: &mut Chording<NUM_CHORDS>,
) -> heapless::Vec<Event, 8>
where
    E: core::fmt::Debug,
{
    let debounced_events = debouncer.events(matrix.get().unwrap());
    chording.tick(debounced_events.collect())
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

pub fn event_transform_lhs(e: Event) -> Event {
    e
}

pub fn event_transform_rhs(e: Event) -> Event {
    e.transform(|i, j| (i, j + 5))
}

pub fn row5_flipped<P>((a, b, c, d, e): (P, P, P, P, P)) -> (P, P, P, P, P) {
    (e, d, c, b, a)
}

pub fn row3_flipped<P>((a, b, c): (P, P, P)) -> (P, P, P) {
    (c, b, a)
}
