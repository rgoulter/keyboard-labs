#![allow(missing_docs)]

pub type PressedKeys<const COLS: usize, const ROWS: usize> = [[bool; COLS]; ROWS];

pub type PressedKeys5x4 = PressedKeys<5, 4>;
pub type PressedKeys1x1 = PressedKeys<1, 1>;
