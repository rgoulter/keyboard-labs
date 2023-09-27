#![allow(missing_docs)]

use core::convert::Infallible;

#[derive(PartialEq, Eq)]
pub struct PressedKeys<const COLS: usize, const ROWS: usize>(pub [[bool; COLS]; ROWS]);

pub type PressedKeys5x4 = PressedKeys<5, 4>;
pub type PressedKeys1x1 = PressedKeys<1, 1>;

impl<const COLS: usize, const ROWS: usize> Default for PressedKeys<COLS, ROWS> {
    fn default() -> Self {
        Self([[false; COLS]; ROWS])
    }
}

impl<'a, const COLS: usize, const ROWS: usize> IntoIterator for &'a PressedKeys<COLS, ROWS> {
    type IntoIter = core::slice::Iter<'a, [bool; COLS]>;
    type Item = &'a [bool; COLS];
    fn into_iter(self) -> Self::IntoIter {
        self.0.iter()
    }
}

pub trait DirectPins<const COLS: usize, const ROWS: usize> {
    fn get(&self) -> Result<PressedKeys<COLS, ROWS>, Infallible>;
}
