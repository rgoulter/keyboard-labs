pub mod rev2021_4;
pub mod rev2021_5;

use stm32f4xx_hal::gpio::{EPin, Input, Pin, PinMode};

pub type Row5 = (
    EPin<Input>,
    EPin<Input>,
    EPin<Input>,
    EPin<Input>,
    EPin<Input>,
);

pub type Row3 = (EPin<Input>, EPin<Input>, EPin<Input>);

pub struct DirectPins5x4(pub Row5, pub Row5, pub Row5, pub Row3);

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
