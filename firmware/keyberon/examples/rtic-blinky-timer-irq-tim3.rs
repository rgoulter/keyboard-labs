#![no_main]
#![no_std]

// set the panic handler
use panic_halt as _;

use rtic::app;
use stm32f4xx_hal::gpio::{gpioc::PC13, Output, PushPull};
use stm32f4xx_hal::prelude::*;
use stm32f4xx_hal::{pac, timer};

#[app(device = stm32f4xx_hal::pac, peripherals = true)]
const APP: () = {
    struct Resources {
        led: PC13<Output<PushPull>>,
        timer: timer::Counter<pac::TIM3, 1000000>,
    }

    #[init]
    fn init(c: init::Context) -> init::LateResources {
        let rcc = c.device.RCC.constrain();
        let clocks = rcc
            .cfgr
            .use_hse(25.MHz())
            .sysclk(84.MHz())
            .require_pll48clk()
            .freeze();

        // Setup LED
        let gpioc = c.device.GPIOC.split();
        let led = gpioc
            .pc13
            .into_push_pull_output();

        let mut timer = c.device.TIM3.counter_us(&clocks);
        timer.start(2000.millis()).unwrap();
        timer.listen(timer::Event::Update);
        unsafe {
            pac::NVIC::unmask(pac::Interrupt::TIM3);
        }

        init::LateResources {
            led,
            timer,
        }
    }

    #[task(binds = TIM3, priority = 1, resources = [timer, led])]
    fn tick(c: tick::Context) {
        c.resources.timer.clear_interrupt(timer::Event::Update);

        c.resources.led.toggle();
    }
};
