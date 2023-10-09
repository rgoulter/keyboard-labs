#![allow(missing_docs)]

use core::convert::Infallible;

pub type PressedKeys<const COLS: usize, const ROWS: usize> = [[bool; COLS]; ROWS];

pub type PressedKeys5x4 = PressedKeys<5, 4>;
pub type PressedKeys1x1 = PressedKeys<1, 1>;

pub trait DirectPins<const COLS: usize, const ROWS: usize> {
    fn get(&self) -> Result<PressedKeys<COLS, ROWS>, Infallible>;
}
