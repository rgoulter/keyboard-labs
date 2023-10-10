use core::convert::Infallible;
use embedded_hal::digital::v2::InputPin;

use keyberon::layout::Event;

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
