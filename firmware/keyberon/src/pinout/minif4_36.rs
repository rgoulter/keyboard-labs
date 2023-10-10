pub mod rev2021_4;
pub mod rev2021_5;

use core::convert::Infallible;
use embedded_hal::digital::v2::InputPin;
use stm32f4xx_hal::gpio::{EPin, Input, Pin, PinMode};

use keyberon::layout::Event;

pub type Row5 = (
    EPin<Input>,
    EPin<Input>,
    EPin<Input>,
    EPin<Input>,
    EPin<Input>,
);

pub type Row3 = (EPin<Input>, EPin<Input>, EPin<Input>);

pub fn erased_input_5<
    const AP: char,
    const AN: u8,
    AM,
    const BP: char,
    const BN: u8,
    BM,
    const CP: char,
    const CN: u8,
    CM,
    const DP: char,
    const DN: u8,
    DM,
    const EP: char,
    const EN: u8,
    EM,
>(
    a: Pin<AP, AN, AM>,
    b: Pin<BP, BN, BM>,
    c: Pin<CP, CN, CM>,
    d: Pin<DP, DN, DM>,
    e: Pin<EP, EN, EM>,
) -> (
    EPin<Input>,
    EPin<Input>,
    EPin<Input>,
    EPin<Input>,
    EPin<Input>,
)
where
    AM: PinMode,
    BM: PinMode,
    CM: PinMode,
    DM: PinMode,
    EM: PinMode,
{
    (
        a.into_pull_up_input().erase(),
        b.into_pull_up_input().erase(),
        c.into_pull_up_input().erase(),
        d.into_pull_up_input().erase(),
        e.into_pull_up_input().erase(),
    )
}

pub fn erased_input_3<
    const AP: char,
    const AN: u8,
    AM,
    const BP: char,
    const BN: u8,
    BM,
    const CP: char,
    const CN: u8,
    CM,
>(
    a: Pin<AP, AN, AM>,
    b: Pin<BP, BN, BM>,
    c: Pin<CP, CN, CM>,
) -> (EPin<Input>, EPin<Input>, EPin<Input>)
where
    AM: PinMode,
    BM: PinMode,
    CM: PinMode,
{
    (
        a.into_pull_up_input().erase(),
        b.into_pull_up_input().erase(),
        c.into_pull_up_input().erase(),
    )
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

pub fn row5_flipped((a, b, c, d, e): Row5) -> Row5 {
    (e, d, c, b, a)
}

pub fn row3_flipped((a, b, c): Row3) -> Row3 {
    (c, b, a)
}
