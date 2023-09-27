#![allow(missing_docs)]

use core::convert::Infallible;
use keyberon::layout::Event;
use stm32f4xx_hal::gpio::{gpioa, gpiob, gpioc, Input, PullUp};

use crate::direct_pin_matrix::{
    DirectPins,
    PressedKeys5x4,
    PressedKeys,
};

pub struct DirectPins5x4(
    pub  (
        gpioc::PC15<Input<PullUp>>,
        gpioa::PA10<Input<PullUp>>,
        gpioa::PA9<Input<PullUp>>,
        gpioa::PA8<Input<PullUp>>,
        gpiob::PB15<Input<PullUp>>,
    ),
    pub  (
        gpiob::PB10<Input<PullUp>>,
        gpiob::PB4<Input<PullUp>>,
        gpiob::PB3<Input<PullUp>>,
        gpioa::PA15<Input<PullUp>>,
        gpiob::PB5<Input<PullUp>>,
    ),
    pub  (
        gpioa::PA6<Input<PullUp>>,
        gpioa::PA7<Input<PullUp>>,
        gpiob::PB0<Input<PullUp>>,
        gpiob::PB1<Input<PullUp>>,
        gpioa::PA2<Input<PullUp>>,
    ),
    pub  (
        gpioa::PA3<Input<PullUp>>,
        gpioa::PA4<Input<PullUp>>,
        gpioa::PA5<Input<PullUp>>,
    ),
);

pub fn direct_pin_matrix_for_peripherals(
    pa2: gpioa::PA2<Input<PullUp>>,
    pa3: gpioa::PA3<Input<PullUp>>,
    pa4: gpioa::PA4<Input<PullUp>>,
    pa5: gpioa::PA5<Input<PullUp>>,
    pa6: gpioa::PA6<Input<PullUp>>,
    pa7: gpioa::PA7<Input<PullUp>>,
    pa8: gpioa::PA8<Input<PullUp>>,
    pa9: gpioa::PA9<Input<PullUp>>,
    pa10: gpioa::PA10<Input<PullUp>>,
    pa15: gpioa::PA15<Input<PullUp>>,
    pb0: gpiob::PB0<Input<PullUp>>,
    pb1: gpiob::PB1<Input<PullUp>>,
    pb3: gpiob::PB3<Input<PullUp>>,
    pb4: gpiob::PB4<Input<PullUp>>,
    pb5: gpiob::PB5<Input<PullUp>>,
    pb10: gpiob::PB10<Input<PullUp>>,
    pb15: gpiob::PB15<Input<PullUp>>,
    pc15: gpioc::PC15<Input<PullUp>>,
) -> DirectPins5x4 {
    DirectPins5x4(
        (pc15, pa10, pa9, pa8, pb15),
        (pb10, pb4, pb3, pa15, pb5),
        (pa6, pa7, pb0, pb1, pa2),
        (pa3, pa4, pa5),
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
