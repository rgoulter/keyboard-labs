#![allow(missing_docs)]

use core::convert::Infallible;
use keyberon::layout::Event;
use stm32f4xx_hal::gpio::{gpioa, gpiob, gpioc, Input};

use crate::direct_pin_matrix::{
    DirectPins,
    PressedKeys5x4,
    PressedKeys,
};

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

pub fn direct_pin_matrix_for_peripherals(
    pa0: gpioa::PA0<Input>,
    pa2: gpioa::PA2<Input>,
    pa4: gpioa::PA4<Input>,
    pa5: gpioa::PA5<Input>,
    pa6: gpioa::PA6<Input>,
    pa8: gpioa::PA8<Input>,
    pa9: gpioa::PA9<Input>,
    pa10: gpioa::PA10<Input>,
    pa15: gpioa::PA15<Input>,
    pb1: gpiob::PB1<Input>,
    pb3: gpiob::PB3<Input>,
    pb5: gpiob::PB5<Input>,
    pb10: gpiob::PB10<Input>,
    pb12: gpiob::PB12<Input>,
    pb13: gpiob::PB13<Input>,
    pb14: gpiob::PB14<Input>,
    pb15: gpiob::PB15<Input>,
    pc13: gpioc::PC13<Input>,
) -> DirectPins5x4 {
    DirectPins5x4(
        (pb3, pa5, pa9, pb15, pb12),
        (pb10, pa15, pa10, pa8, pb13),
        (pb5, pa4, pa6, pb1, pb14),
        (pc13, pa0, pa2)
    )
}

impl DirectPins<5, 4> for DirectPins5x4 {
    fn get(&self) -> Result<PressedKeys5x4, Infallible> {
        let row1 = &self.0;
        let row2 = &self.1;
        let row3 = &self.2;
        let row4 = &self.3;
        Ok(PressedKeys([
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
        ]))
    }
}

pub fn event_transform(e: Event) -> Event {
    e.transform(|i, j| (i, j + 5))
}
