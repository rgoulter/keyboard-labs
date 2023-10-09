#![allow(missing_docs)]

use core::convert::Infallible;
use stm32f4xx_hal::gpio::{gpioa, gpiob, gpioc};

use crate::common::Matrix;
use crate::direct_pin_matrix::PressedKeys5x4;

pub use super::event_transform_rhs as event_transform;
use super::{Row3, Row5, erased_input_5, erased_input_3, row5_is_low, row3_is_low_rhs as row3_is_low};

pub struct DirectPins5x4(
    pub  Row5,
    pub  Row5,
    pub  Row5,
    pub  Row3,
);

pub fn direct_pin_matrix_for_peripherals<A15M: stm32f4xx_hal::gpio::PinMode, B3M: stm32f4xx_hal::gpio::PinMode>(
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
) -> DirectPins5x4 {
    DirectPins5x4(
        erased_input_5(pb3, pa5, pa9, pb15, pb12),
        erased_input_5(pb10, pa15, pa10, pa8, pb13),
        erased_input_5(pb5, pa4, pa6, pb1, pb14),
        erased_input_3(pc13, pa0, pa2),
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
