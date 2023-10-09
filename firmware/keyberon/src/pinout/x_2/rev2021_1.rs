use stm32f4xx_hal::gpio::{gpioa, gpiob, EPin, Input, Output};

pub fn cols_and_rows_for_peripherals<PMA15: stm32f4xx_hal::gpio::PinMode>(
    pa3: gpioa::PA3,
    pa4: gpioa::PA4,
    pa5: gpioa::PA5,
    pa6: gpioa::PA6,
    pa7: gpioa::PA7,
    pa8: gpioa::PA8,
    pa10: gpioa::PA10,
    pa15: gpioa::PA15<PMA15>,
    pb1: gpiob::PB1,
    pb5: gpiob::PB5,
    pb6: gpiob::PB6,
    pb7: gpiob::PB7,
    pb8: gpiob::PB8,
    pb12: gpiob::PB12,
    pb13: gpiob::PB13,
    pb14: gpiob::PB14,
    pb15: gpiob::PB15,
) -> ([EPin<Input>; 12], [EPin<Output>; 5])
{
    (
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
        ],
        [
            pa10.into_push_pull_output().erase(), // row1
            pb5.into_push_pull_output().erase(),  // row2
            pb6.into_push_pull_output().erase(),  // row3
            pb7.into_push_pull_output().erase(),  // row4
            pb8.into_push_pull_output().erase(),  // row5
        ],
    )
}
