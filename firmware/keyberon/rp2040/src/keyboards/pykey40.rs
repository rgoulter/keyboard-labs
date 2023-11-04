use rp2040_hal as hal;

use hal::gpio::bank0;

use crate::input::{Input, Output, UnconfiguredPin};
use keyboard_labs_keyberon::matrix::Matrix;

pub const COLS: usize = 12;
pub const ROWS: usize = 4;

pub fn cols(
    gp0: UnconfiguredPin<bank0::Gpio0>,
    gp1: UnconfiguredPin<bank0::Gpio1>,
    gp2: UnconfiguredPin<bank0::Gpio2>,
    gp3: UnconfiguredPin<bank0::Gpio3>,
    gp4: UnconfiguredPin<bank0::Gpio4>,
    gp5: UnconfiguredPin<bank0::Gpio5>,
    gp6: UnconfiguredPin<bank0::Gpio6>,
    gp7: UnconfiguredPin<bank0::Gpio7>,
    gp8: UnconfiguredPin<bank0::Gpio8>,
    gp9: UnconfiguredPin<bank0::Gpio9>,
    gp10: UnconfiguredPin<bank0::Gpio10>,
    gp11: UnconfiguredPin<bank0::Gpio11>,
) -> [Input; COLS] {
    [
        gp0.into_pull_up_input().into_dyn_pin(),
        gp1.into_pull_up_input().into_dyn_pin(),
        gp2.into_pull_up_input().into_dyn_pin(),
        gp3.into_pull_up_input().into_dyn_pin(),
        gp4.into_pull_up_input().into_dyn_pin(),
        gp5.into_pull_up_input().into_dyn_pin(),
        gp6.into_pull_up_input().into_dyn_pin(),
        gp7.into_pull_up_input().into_dyn_pin(),
        gp8.into_pull_up_input().into_dyn_pin(),
        gp9.into_pull_up_input().into_dyn_pin(),
        gp10.into_pull_up_input().into_dyn_pin(),
        gp11.into_pull_up_input().into_dyn_pin(),
    ]
}

pub fn rows(
    gp14: UnconfiguredPin<bank0::Gpio14>,
    gp15: UnconfiguredPin<bank0::Gpio15>,
    gp16: UnconfiguredPin<bank0::Gpio16>,
    gp17: UnconfiguredPin<bank0::Gpio17>,
) -> [Output; ROWS] {
    [
        gp14.into_push_pull_output().into_dyn_pin(),
        gp15.into_push_pull_output().into_dyn_pin(),
        gp16.into_push_pull_output().into_dyn_pin(),
        gp17.into_push_pull_output().into_dyn_pin(),
    ]
}

// N: num chords
pub type Keyboard<const N: usize> = keyboard_labs_keyberon::input::Keyboard<
    COLS,
    ROWS,
    N,
    Matrix<Input, Output, COLS, ROWS, hal::Timer>,
>;
