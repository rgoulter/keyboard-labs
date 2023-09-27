#![no_main]
#![no_std]

// set the panic handler
use panic_halt as _;

use core::convert::Infallible;

use keyberon::debounce::Debouncer;
use keyberon::key_code::{KbHidReport, KeyCode};
use rtic::app;
use stm32f4xx_hal::delay::Delay;
use stm32f4xx_hal::gpio::{Input, PullUp};
use stm32f4xx_hal::gpio::gpioa;
use stm32f4xx_hal::otg_fs::{UsbBusType, USB};
use stm32f4xx_hal::pac::TIM5;
use stm32f4xx_hal::prelude::*;
use stm32f4xx_hal::{pac, timer};
use usb_device::bus::UsbBusAllocator;
use usb_device::class::UsbClass as _;

use keyboard_labs_keyberon::common::{
    UsbClass,
    UsbDevice,
};
use keyboard_labs_keyberon::direct_pin_matrix::{
    DirectPins,
    PressedKeys1x1,
    PressedKeys,
};

const COLS: usize = 1;
const ROWS: usize = 1;
const NUM_LAYERS: usize = 1;

type Layers = keyberon::layout::Layers<COLS, ROWS, NUM_LAYERS, ()>;
type Layout = keyberon::layout::Layout<COLS, ROWS, NUM_LAYERS, ()>;

pub static LAYERS: Layers = keyberon::layout::layout! {
    {
        [A],
    }
};

pub struct DirectPins1x1(
    pub  (
        gpioa::PA0<Input<PullUp>>,
    )
);

impl DirectPins<COLS, ROWS> for DirectPins1x1 {
    fn get(&self) -> Result<PressedKeys1x1, Infallible> {
        let row1 = &self.0;
        Ok(PressedKeys([
            [
                row1.0.is_low(),
            ],
        ]))
    }
}

#[app(device = stm32f4xx_hal::pac, peripherals = true)]
const APP: () = {
    struct Resources {
        usb_dev: UsbDevice,
        usb_class: UsbClass,
        direct_pins: DirectPins1x1,
        debouncer: Debouncer<PressedKeys1x1>,
        layout: Layout,
        timer: timer::CountDownTimer<pac::TIM3>,
    }

    #[init]
    fn init(c: init::Context) -> init::LateResources {
        static mut EP_MEMORY: [u32; 1024] = [0; 1024];
        static mut USB_BUS: Option<UsbBusAllocator<UsbBusType>> = None;

        let rcc = c.device.RCC.constrain();
        let clocks = rcc
            .cfgr
            .use_hse(25.mhz())
            .sysclk(84.mhz())
            .require_pll48clk()
            .freeze();
        let gpioa = c.device.GPIOA.split();
        let gpiob = c.device.GPIOB.split();

        let usb = USB {
            usb_global: c.device.OTG_FS_GLOBAL,
            usb_device: c.device.OTG_FS_DEVICE,
            usb_pwrclk: c.device.OTG_FS_PWRCLK,
            pin_dm: gpioa.pa11.into_alternate(),
            pin_dp: gpioa.pa12.into_alternate(),
            hclk: clocks.hclk(),
        };
        *USB_BUS = Some(UsbBusType::new(usb, EP_MEMORY));
        let usb_bus = USB_BUS.as_ref().unwrap();

        let usb_class = keyberon::new_class(usb_bus, ());
        let usb_dev = keyberon::new_device(usb_bus);

        let mut timer = timer::Timer::new(c.device.TIM3, &clocks).start_count_down(1.khz());
        timer.listen(timer::Event::TimeOut);

        let delay: Delay<TIM5> = Delay::<TIM5>::tim5(c.device.TIM5, &clocks);
        let direct_pins = DirectPins1x1(
            (gpioa.pa0.into_pull_up_input(),),
        );

        init::LateResources {
            usb_dev,
            usb_class,
            timer,
            // 1x1 debouncer
            debouncer: Debouncer::new(PressedKeys1x1::default(), PressedKeys1x1::default(), 5),
            direct_pins,
            layout: Layout::new(&LAYERS),
        }
    }

    #[task(binds = OTG_FS, priority = 2, resources = [usb_dev, usb_class])]
    fn usb_tx(mut c: usb_tx::Context) {
        usb_poll(&mut c.resources.usb_dev, &mut c.resources.usb_class);
    }

    #[task(binds = OTG_FS_WKUP, priority = 2, resources = [usb_dev, usb_class])]
    fn usb_rx(mut c: usb_rx::Context) {
        usb_poll(&mut c.resources.usb_dev, &mut c.resources.usb_class);
    }

    #[task(binds = TIM3, priority = 1, resources = [usb_class, direct_pins, debouncer, layout, timer])]
    fn tick(mut c: tick::Context) {
        c.resources.timer.clear_interrupt(timer::Event::TimeOut);


        let events = c
            .resources
            .debouncer
            .events(c.resources.direct_pins.get().unwrap());

        for event in events
        {
            c.resources.layout.event(event);
        }
        match c.resources.layout.tick() {
            keyberon::layout::CustomEvent::Release(()) => unsafe {
                cortex_m::asm::bootload(0x1FFF0000 as _)
            },
            _ => (),
        }
        send_report(c.resources.layout.keycodes(), &mut c.resources.usb_class);
    }
};

fn send_report(iter: impl Iterator<Item = KeyCode>, usb_class: &mut resources::usb_class<'_>) {
    use rtic::Mutex;
    let report: KbHidReport = iter.collect();
    if usb_class.lock(|k| k.device_mut().set_keyboard_report(report.clone())) {
        while let Ok(0) = usb_class.lock(|k| k.write(report.as_bytes())) {}
    }
}

fn usb_poll(usb_dev: &mut UsbDevice, keyboard: &mut UsbClass) {
    if usb_dev.poll(&mut [keyboard]) {
        keyboard.poll();
    }
}
