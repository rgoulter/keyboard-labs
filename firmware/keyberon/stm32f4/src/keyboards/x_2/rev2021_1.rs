use stm32f4xx_hal as hal;

// use embedded_hal::blocking::delay::DelayUs;
use hal::gpio::{gpioa, gpiob, EPin, Input, Output, PinMode};
use keyboard_labs_keyberon::matrix::Matrix;

pub const COLS: usize = 12;
pub const ROWS: usize = 5;

pub fn cols<PMA15: PinMode>(
    pa3: gpioa::PA3,
    pa4: gpioa::PA4,
    pa5: gpioa::PA5,
    pa6: gpioa::PA6,
    pa7: gpioa::PA7,
    pa8: gpioa::PA8,
    pa15: gpioa::PA15<PMA15>,
    pb1: gpiob::PB1,
    pb12: gpiob::PB12,
    pb13: gpiob::PB13,
    pb14: gpiob::PB14,
    pb15: gpiob::PB15,
) -> [EPin<Input>; COLS] {
    [
        pb12.into_pull_up_input().erase(), // col1
        pb13.into_pull_up_input().erase(), // col2
        pb14.into_pull_up_input().erase(), // col3
        pb15.into_pull_up_input().erase(), // col4
        pa8.into_pull_up_input().erase(),  // col5
        pa15.into_pull_up_input().erase(), // col6
        pa3.into_pull_up_input().erase(),  // col7
        pa4.into_pull_up_input().erase(),  // col8
        pa5.into_pull_up_input().erase(),  // col9
        pa6.into_pull_up_input().erase(),  // col10
        pa7.into_pull_up_input().erase(),  // col11
        pb1.into_pull_up_input().erase(),  // col12
    ]
}

pub fn rows(
    pa10: gpioa::PA10,
    pb5: gpiob::PB5,
    pb6: gpiob::PB6,
    pb7: gpiob::PB7,
    pb8: gpiob::PB8,
) -> [EPin<Output>; ROWS] {
    [
        pa10.into_push_pull_output().erase(), // row1
        pb5.into_push_pull_output().erase(),  // row2
        pb6.into_push_pull_output().erase(),  // row3
        pb7.into_push_pull_output().erase(),  // row4
        pb8.into_push_pull_output().erase(),  // row5
    ]
}

// N: num chords
pub type Keyboard<const N: usize, TIM> = keyboard_labs_keyberon::input::Keyboard<
    COLS,
    ROWS,
    N,
    Matrix<EPin<Input>, EPin<Output>, COLS, ROWS, hal::timer::delay::DelayUs<TIM>>,
>;
