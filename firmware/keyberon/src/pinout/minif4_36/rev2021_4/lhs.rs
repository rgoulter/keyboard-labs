#![allow(missing_docs)]

use core::convert::Infallible;
use stm32f4xx_hal::gpio::{gpioa, gpiob};

use crate::common::Matrix;
use crate::direct_pin_matrix::PressedKeys5x4;

pub use crate::pinout::minif4_36::event_transform_lhs as event_transform;
use crate::pinout::minif4_36::{
    erased_input_3, erased_input_5, row3_is_low_lhs as row3_is_low, row5_is_low, Row3, Row5,
};

pub struct DirectPins5x4(pub Row5, pub Row5, pub Row5, pub Row3);

pub fn direct_pin_matrix_for_peripherals<
    B4M: stm32f4xx_hal::gpio::PinMode,
    A15M: stm32f4xx_hal::gpio::PinMode,
    B3M: stm32f4xx_hal::gpio::PinMode,
>(
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
) -> DirectPins5x4 {
    DirectPins5x4(
        erased_input_5(pb15, pa8, pa9, pa10, pa2),
        erased_input_5(pb5, pa15, pb3, pb4, pb10),
        erased_input_5(pa1, pb1, pb0, pa7, pa6),
        erased_input_3(pa5, pa4, pa3),
    )
}

impl Matrix<5, 4> for DirectPins5x4 {
    fn get(&mut self) -> Result<PressedKeys5x4, Infallible> {
        let DirectPins5x4(row1, row2, row3, row4) = self;
        Ok([
            row5_is_low(row1),
            row5_is_low(row2),
            row5_is_low(row3),
            row3_is_low(row4),
        ])
    }
}
