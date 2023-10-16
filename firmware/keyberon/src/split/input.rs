use keyberon::chording::Chording;
use keyberon::debounce::Debouncer;
use keyberon::layout::Event;

use crate::input::{MatrixScanner, PressedKeys};

pub fn event_transform_lhs(e: Event) -> Event {
    e
}

pub fn event_transform_rhs(e: Event) -> Event {
    e.transform(|i, j| (i, j + 5))
}

pub struct Keyboard<
    const COLS: usize,
    const ROWS: usize,
    const NUM_CHORDS: usize,
    M: MatrixScanner<COLS, ROWS>,
> {
    pub matrix: M,
    pub debouncer: Debouncer<PressedKeys<COLS, ROWS>>,
    pub event_transform: fn(Event) -> Event,
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
        event_transform: fn(Event) -> Event,
        chording: Chording<NUM_CHORDS>,
    ) -> Self {
        Self {
            matrix,
            debouncer,
            event_transform,
            chording,
        }
    }

    pub fn events(&mut self) -> heapless::Vec<Event, 8> {
        let key_presses = self.matrix.get().unwrap();
        let debounced_events = self.debouncer.events(key_presses);
        let transformed_events = debounced_events.map(self.event_transform).collect();
        self.chording.tick(transformed_events)
    }
}
