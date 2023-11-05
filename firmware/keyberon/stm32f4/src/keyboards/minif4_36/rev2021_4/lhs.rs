#![allow(missing_docs)]

use core::convert::Infallible;

use stm32f4xx_hal as hal;

use hal::gpio::{gpioa, gpiob, PinMode};

use keyboard_labs_keyberon::input::{MatrixScanner, PressedKeys5x4};

use keyboard_labs_keyberon::input::{row3_is_low_lhs as row3_is_low, row5_is_low};
pub use keyboard_labs_keyberon::split::input::event_transform_lhs as event_transform;

use crate::keyboards::minif4_36::{erased_input_3, erased_input_5, DirectPins5x4};

pub const COLS: usize = 5; // split side only
pub const ROWS: usize = 4;

pub struct LHS(pub DirectPins5x4);

pub fn direct_pin_matrix_for_peripherals<B4M: PinMode, A15M: PinMode, B3M: PinMode>(
    pa1: gpioa::PA1,
    pa2: gpioa::PA2,
    pa3: gpioa::PA3,
    pa4: gpioa::PA4,
    pa5: gpioa::PA5,
    pa6: gpioa::PA6,
    pa7: gpioa::PA7,
    pa8: gpioa::PA8,
    pa9: gpioa::PA9,
    pa10: gpioa::PA10,
    pa15: gpioa::PA15<A15M>,
    pb0: gpiob::PB0,
    pb1: gpiob::PB1,
    pb3: gpiob::PB3<B3M>,
    pb4: gpiob::PB4<B4M>,
    pb5: gpiob::PB5,
    pb10: gpiob::PB10,
    pb15: gpiob::PB15,
) -> LHS {
    LHS(DirectPins5x4(
        erased_input_5(pb15, pa8, pa9, pa10, pa2),
        erased_input_5(pb5, pa15, pb3, pb4, pb10),
        erased_input_5(pa1, pb1, pb0, pa7, pa6),
        erased_input_3(pa5, pa4, pa3),
    ))
}

impl MatrixScanner<5, 4> for LHS {
    fn get(&mut self) -> Result<PressedKeys5x4, Infallible> {
        let LHS(DirectPins5x4(row1, row2, row3, row4)) = self;
        Ok([
            row5_is_low(row1),
            row5_is_low(row2),
            row5_is_low(row3),
            row3_is_low(row4),
        ])
    }
}

// N: num chords
pub type Keyboard<const N: usize> = keyboard_labs_keyberon::input::Keyboard<COLS, ROWS, N, LHS>;
