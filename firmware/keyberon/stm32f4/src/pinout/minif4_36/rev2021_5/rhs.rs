#![allow(missing_docs)]

use core::convert::Infallible;
use stm32f4xx_hal::gpio::{gpioa, gpiob, gpioc};

use keyboard_labs_keyberon::input::{MatrixScanner, PressedKeys5x4};

use keyboard_labs_keyberon::input::{
    row3_flipped, row3_is_low_rhs as row3_is_low, row5_flipped, row5_is_low,
};
use keyboard_labs_keyberon::split::input::event_transform_rhs;

use crate::pinout::minif4_36::DirectPins5x4;

pub const COLS: usize = 5; // split side only
pub const ROWS: usize = 4;

pub struct RHS(pub DirectPins5x4);

#[allow(non_upper_case_globals)]
pub const event_transform: fn(keyberon::layout::Event) -> keyberon::layout::Event =
    event_transform_rhs::<COLS>;

pub fn direct_pin_matrix_for_peripherals<
    A15M: stm32f4xx_hal::gpio::PinMode,
    B3M: stm32f4xx_hal::gpio::PinMode,
>(
    pa0: gpioa::PA0,
    pa2: gpioa::PA2,
    pa4: gpioa::PA4,
    pa5: gpioa::PA5,
    pa6: gpioa::PA6,
    pa8: gpioa::PA8,
    pa9: gpioa::PA9,
    pa10: gpioa::PA10,
    pa15: gpioa::PA15<A15M>,
    pb1: gpiob::PB1,
    pb3: gpiob::PB3<B3M>,
    pb5: gpiob::PB5,
    pb10: gpiob::PB10,
    pb12: gpiob::PB12,
    pb13: gpiob::PB13,
    pb14: gpiob::PB14,
    pb15: gpiob::PB15,
    pc13: gpioc::PC13,
) -> RHS {
    let super::lhs::LHS(DirectPins5x4(row1, row2, row3, row4)) =
        super::lhs::direct_pin_matrix_for_peripherals(
            pa0, pa2, pa4, pa5, pa6, pa8, pa9, pa10, pa15, pb1, pb3, pb5, pb10, pb12, pb13, pb14,
            pb15, pc13,
        );
    RHS(DirectPins5x4(
        row5_flipped(row1),
        row5_flipped(row2),
        row5_flipped(row3),
        row3_flipped(row4),
    ))
}

impl MatrixScanner<5, 4> for RHS {
    fn get(&mut self) -> Result<PressedKeys5x4, Infallible> {
        let RHS(DirectPins5x4(row1, row2, row3, row4)) = self;
        Ok([
            row5_is_low(row1),
            row5_is_low(row2),
            row5_is_low(row3),
            row3_is_low(row4),
        ])
    }
}

// N: num chords
pub type Keyboard<const N: usize> = keyboard_labs_keyberon::input::Keyboard<COLS, ROWS, N, RHS>;
