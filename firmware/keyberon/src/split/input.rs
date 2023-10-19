use keyberon::layout::Event;

pub fn event_transform_lhs(e: Event) -> Event {
    e
}

pub fn event_transform_rhs<const COLS: usize>(e: Event) -> Event {
    e.transform(|i, j| (i, j + COLS as u8))
}
