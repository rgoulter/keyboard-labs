#![allow(missing_docs)]

use core::convert::Infallible;
use stm32f4xx_hal::gpio::{gpioa, gpiob, gpioc};

use crate::common::Matrix;
use crate::direct_pin_matrix::PressedKeys5x4;

pub use crate::pinout::minif4_36::event_transform_lhs as event_transform;
use crate::pinout::minif4_36::{
    erased_input_3, erased_input_5, row3_is_low_lhs as row3_is_low, row5_is_low, Row3, Row5,
};

pub struct DirectPins5x4(pub Row5, pub Row5, pub Row5, pub Row3);

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
) -> DirectPins5x4 {
    DirectPins5x4(
        erased_input_5(pb12, pb15, pa9, pa5, pb3),
        erased_input_5(pb13, pa8, pa10, pa15, pb10),
        erased_input_5(pb14, pb1, pa6, pa4, pb5),
        erased_input_3(pa2, pa0, pc13),
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
