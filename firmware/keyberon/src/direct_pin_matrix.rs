#![allow(missing_docs)]

use core::convert::Infallible;

#[derive(Default, PartialEq, Eq)]
pub struct PressedKeys5x4(pub [[bool; 5]; 4]);

impl<'a> IntoIterator for &'a PressedKeys5x4 {
    type IntoIter = core::slice::Iter<'a, [bool; 5]>;
    type Item = &'a [bool; 5];
    fn into_iter(self) -> Self::IntoIter {
        self.0.iter()
    }
}

pub trait DirectPins {
    fn get(&self) -> Result<PressedKeys5x4, Infallible>;
}

