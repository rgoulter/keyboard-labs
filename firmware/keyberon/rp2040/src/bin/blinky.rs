#![no_std]
#![no_main]

#[rtic::app(
    device = rp_pico::hal::pac,
    dispatchers = [TIMER_IRQ_1]
)]
mod app {
    use rp2040_monotonic::{
        fugit::Duration,
        Rp2040Monotonic,
    };
    use rp_pico::hal::{
        clocks, gpio,
        gpio::bank0::Gpio25,
        gpio::FunctionSio,
        gpio::SioOutput,
        gpio::PullDown,
        sio::Sio,
        watchdog::Watchdog,
    };
    use rp_pico::XOSC_CRYSTAL_FREQ;

    use embedded_hal::digital::v2::{OutputPin, ToggleableOutputPin};

    use panic_halt as _;

    const MONO_NUM: u32 = 1;
    const MONO_DENOM: u32 = 1000000;
    const ONE_SEC_TICKS: u64 = 1000000;

    #[monotonic(binds = TIMER_IRQ_0, default = true)]
    type Rp2040Mono = Rp2040Monotonic;

    #[shared]
    struct Shared {}

    #[local]
    struct Local {
        led: gpio::Pin<Gpio25, FunctionSio<SioOutput>, PullDown>,
    }

    #[init(local=[
    ])]
    fn init(mut ctx: init::Context) -> (Shared, Local, init::Monotonics) {
        // Configure the clocks, watchdog - The default is to generate a 125 MHz system clock
        let mut watchdog = Watchdog::new(ctx.device.WATCHDOG);
        let _clocks = clocks::init_clocks_and_plls(
            XOSC_CRYSTAL_FREQ,
            ctx.device.XOSC,
            ctx.device.CLOCKS,
            ctx.device.PLL_SYS,
            ctx.device.PLL_USB,
            &mut ctx.device.RESETS,
            &mut watchdog,
        )
        .ok()
        .unwrap();

        // Init LED pin
        let sio = Sio::new(ctx.device.SIO);
        let gpioa = rp_pico::Pins::new(
            ctx.device.IO_BANK0,
            ctx.device.PADS_BANK0,
            sio.gpio_bank0,
            &mut ctx.device.RESETS,
        );
        let mut led = gpioa.led.into_push_pull_output();
        led.set_low().unwrap();

        let mono = Rp2040Mono::new(ctx.device.TIMER);

        // Spawn heartbeat task
        heartbeat::spawn().unwrap();

        // Return resources and timer
        (
            Shared {},
            Local { led,  },
            init::Monotonics(mono),
        )
    }

    #[task(local = [led])]
    fn heartbeat(ctx: heartbeat::Context) {
        // Flicker the built-in LED
        _ = ctx.local.led.toggle();

        // Re-spawn this task after 1 second
        let one_second = Duration::<u64, MONO_NUM, MONO_DENOM>::from_ticks(ONE_SEC_TICKS);
        heartbeat::spawn_after(one_second).unwrap();
    }
}
