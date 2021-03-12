#![allow(missing_docs)]

use core::convert::Infallible;
use embedded_hal::digital::v2::InputPin;
use keyberon::layout::Event;

#[cfg(keyboard_revision = "2020.1")]
use crate::rev2020_1 as pin_layout;
#[cfg(keyboard_revision = "2021.1")]
use crate::rev2021_1 as pin_layout;

pub use pin_layout::{direct_pin_matrix_for_peripherals, DirectPins5x4};

pub trait HeterogenousArray {
    type Len;
}

impl DirectPins5x4 {
    #[cfg(feature = "split-left")]
    pub fn get(&self) -> Result<PressedKeys5x4, Infallible> {
        let row1 = &self.0;
        let row2 = &self.1;
        let row3 = &self.2;
        let row4 = &self.3;
        Ok(PressedKeys5x4([
            [
                row1.0.is_low()?,
                row1.1.is_low()?,
                row1.2.is_low()?,
                row1.3.is_low()?,
                row1.4.is_low()?,
            ],
            [
                row2.0.is_low()?,
                row2.1.is_low()?,
                row2.2.is_low()?,
                row2.3.is_low()?,
                row2.4.is_low()?,
            ],
            [
                row3.0.is_low()?,
                row3.1.is_low()?,
                row3.2.is_low()?,
                row3.3.is_low()?,
                row3.4.is_low()?,
            ],
            [
                false,
                false,
                row4.0.is_low()?,
                row4.1.is_low()?,
                row4.2.is_low()?,
            ],
        ]))
    }
    #[cfg(feature = "split-right")]
    pub fn get(&self) -> Result<PressedKeys5x4, Infallible> {
        let row1 = &self.0;
        let row2 = &self.1;
        let row3 = &self.2;
        let row4 = &self.3;
        Ok(PressedKeys5x4([
            [
                row1.0.is_low()?,
                row1.1.is_low()?,
                row1.2.is_low()?,
                row1.3.is_low()?,
                row1.4.is_low()?,
            ],
            [
                row2.0.is_low()?,
                row2.1.is_low()?,
                row2.2.is_low()?,
                row2.3.is_low()?,
                row2.4.is_low()?,
            ],
            [
                row3.0.is_low()?,
                row3.1.is_low()?,
                row3.2.is_low()?,
                row3.3.is_low()?,
                row3.4.is_low()?,
            ],
            [
                row4.0.is_low()?,
                row4.1.is_low()?,
                row4.2.is_low()?,
                false,
                false,
            ],
        ]))
    }
}

#[cfg(feature = "split-left")]
pub fn event_transform(e: Event) -> Event {
    e
}

#[cfg(feature = "split-right")]
pub fn event_transform(e: Event) -> Event {
    e.transform(|i, j| (i, j + 5))
}

#[derive(Default, PartialEq, Eq)]
pub struct PressedKeys5x4(pub [[bool; 5]; 4]);

impl<'a> IntoIterator for &'a PressedKeys5x4 {
    type IntoIter = core::slice::Iter<'a, [bool; 5]>;
    type Item = &'a [bool; 5];
    fn into_iter(self) -> Self::IntoIter {
        self.0.iter()
    }
}
