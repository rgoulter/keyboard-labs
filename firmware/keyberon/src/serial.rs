#![no_main]
#![no_std]

use panic_halt as _;

use cortex_m;
use cortex_m_rt::entry;
use nb::block;
use stm32f4xx_hal as hal;

use crate::hal::{prelude::*, serial::config::Config, serial::Serial, stm32};

use core::fmt::Write; // for pretty formatting of the serial output

#[entry]
fn main() -> ! {
    let dp = stm32::Peripherals::take().unwrap();
    let cp = cortex_m::peripheral::Peripherals::take().unwrap();

    let gpiob = dp.GPIOB.split();

    let rcc = dp.RCC.constrain();

    // does NOT work with hse of 8mhz and baudrate of 9600
    let clocks = rcc
        .cfgr
        .use_hse(25.mhz())
        .sysclk(84.mhz())
        .require_pll48clk()
        .freeze();

    let mut delay = hal::delay::Delay::new(cp.SYST, clocks);

    // define RX/TX pins
    // let tx_pin = gpioa.pa2.into_alternate_af7();
    // let rx_pin = gpioa.pa3.into_alternate_af7();
    let tx_pin = gpiob.pb6.into_alternate_af7();
    let rx_pin = gpiob.pb7.into_alternate_af7();

    // configure serial
    let serial = Serial::usart1(
        dp.USART1,
        (tx_pin, rx_pin),
        Config::default().baudrate(9600.bps()),
        clocks,
    )
    .unwrap();

    let (mut tx, mut _rx) = serial.split();

    loop {
        // print some value every 500 ms, value will overflow after 255
        // writeln!(tx, "value: {:02}\r", value).unwrap();
        // writeln!(tx, "abc").unwrap();

        // block!(tx.write(b'a')).unwrap();
        // block!(tx.write(b'b')).unwrap();
        // block!(tx.write(b'c')).unwrap();
        // block!(tx.write(b'\n')).unwrap();

        block!(tx.write(0)).unwrap();
        block!(tx.write(1)).unwrap();
        block!(tx.write(2)).unwrap();
        block!(tx.write(3)).unwrap();

        block!(tx.flush()).unwrap();
        delay.delay_ms(3000_u32);
    }
}
