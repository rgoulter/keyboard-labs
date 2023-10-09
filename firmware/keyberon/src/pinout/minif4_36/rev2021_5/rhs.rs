#![allow(missing_docs)]

use core::convert::Infallible;
use keyberon::layout::Event;
use stm32f4xx_hal::gpio::{gpioa, gpiob, gpioc, Input};

use crate::common::Matrix;
use crate::direct_pin_matrix::PressedKeys5x4;

pub struct DirectPins5x4(
    pub  (
        gpiob::PB3<Input>,
        gpioa::PA5<Input>,
        gpioa::PA9<Input>,
        gpiob::PB15<Input>,
        gpiob::PB12<Input>,
    ),
    pub  (
        gpiob::PB10<Input>,
        gpioa::PA15<Input>,
        gpioa::PA10<Input>,
        gpioa::PA8<Input>,
        gpiob::PB13<Input>,
    ),
    pub  (
        gpiob::PB5<Input>,
        gpioa::PA4<Input>,
        gpioa::PA6<Input>,
        gpiob::PB1<Input>,
        gpiob::PB14<Input>,
    ),
    pub  (
        gpioc::PC13<Input>,
        gpioa::PA0<Input>,
        gpioa::PA2<Input>,
    ),
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
        (pb3.into_pull_up_input(), pa5.into_pull_up_input(), pa9.into_pull_up_input(), pb15.into_pull_up_input(), pb12.into_pull_up_input()),
        (pb10.into_pull_up_input(), pa15.into_pull_up_input(), pa10.into_pull_up_input(), pa8.into_pull_up_input(), pb13.into_pull_up_input()),
        (pb5.into_pull_up_input(), pa4.into_pull_up_input(), pa6.into_pull_up_input(), pb1.into_pull_up_input(), pb14.into_pull_up_input()),
        (pc13.into_pull_up_input(), pa0.into_pull_up_input(), pa2.into_pull_up_input())
    )
}

impl Matrix<5, 4> for DirectPins5x4 {
    fn get(&mut self) -> Result<PressedKeys5x4, Infallible> {
        let row1 = &self.0;
        let row2 = &self.1;
        let row3 = &self.2;
        let row4 = &self.3;
        Ok([
            [
                row1.0.is_low(),
                row1.1.is_low(),
                row1.2.is_low(),
                row1.3.is_low(),
                row1.4.is_low(),
            ],
            [
                row2.0.is_low(),
                row2.1.is_low(),
                row2.2.is_low(),
                row2.3.is_low(),
                row2.4.is_low(),
            ],
            [
                row3.0.is_low(),
                row3.1.is_low(),
                row3.2.is_low(),
                row3.3.is_low(),
                row3.4.is_low(),
            ],
            [
                row4.0.is_low(),
                row4.1.is_low(),
                row4.2.is_low(),
                false,
                false,
            ],
        ])
    }
}

pub fn event_transform(e: Event) -> Event {
    e.transform(|i, j| (i, j + 5))
}
