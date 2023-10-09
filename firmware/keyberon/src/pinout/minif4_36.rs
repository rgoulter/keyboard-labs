pub mod rev2021_4;
pub mod rev2021_5;

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

pub fn row5_is_low(
    (a, b, c, d, e): &(
        EPin<Input>,
        EPin<Input>,
        EPin<Input>,
        EPin<Input>,
        EPin<Input>,
    ),
) -> [bool; 5] {
    [a.is_low(), b.is_low(), c.is_low(), d.is_low(), e.is_low()]
}

pub fn row3_is_low_lhs((a, b, c): &(EPin<Input>, EPin<Input>, EPin<Input>)) -> [bool; 5] {
    [false, false, a.is_low(), b.is_low(), c.is_low()]
}

pub fn row3_is_low_rhs((a, b, c): &(EPin<Input>, EPin<Input>, EPin<Input>)) -> [bool; 5] {
    [a.is_low(), b.is_low(), c.is_low(), false, false]
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
