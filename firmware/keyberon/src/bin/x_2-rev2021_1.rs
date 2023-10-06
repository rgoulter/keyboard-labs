#![no_main]
#![no_std]

// set the panic handler
use panic_halt as _;

use keyberon::chording::Chording;
use keyberon::debounce::Debouncer;
use keyberon::key_code::{KbHidReport, KeyCode};
use rtic::app;
use stm32f4xx_hal::timer::delay::DelayUs;
use stm32f4xx_hal::gpio::{EPin, Input, Output, PushPull};
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
use keyboard_labs_keyberon::layouts::ortho_5x12::{COLS, ROWS, CHORDS, LAYERS, Layout};
use keyboard_labs_keyberon::matrix::Matrix as DelayedMatrix;

#[app(device = stm32f4xx_hal::pac, peripherals = true)]
const APP: () = {
    struct Resources {
        usb_dev: UsbDevice,
        usb_class: UsbClass,
        matrix: DelayedMatrix<EPin<Input>, EPin<Output<PushPull>>, COLS, ROWS, 1_000_000>,
        debouncer: Debouncer<[[bool; COLS]; ROWS]>,
        layout: Layout,
        chording: Chording<2>,
        timer: timer::CounterUs<pac::TIM3>,
    }

    #[init]
    fn init(c: init::Context) -> init::LateResources {
        static mut EP_MEMORY: [u32; 1024] = [0; 1024];
        static mut USB_BUS: Option<UsbBusAllocator<UsbBusType>> = None;

        let rcc = c.device.RCC.constrain();
        let clocks = rcc
            .cfgr
            .use_hse(25.MHz())
            .sysclk(84.MHz())
            .require_pll48clk()
            .freeze();
        let gpioa = c.device.GPIOA.split();
        let gpiob = c.device.GPIOB.split();

        let usb = USB {
            usb_global: c.device.OTG_FS_GLOBAL,
            usb_device: c.device.OTG_FS_DEVICE,
            usb_pwrclk: c.device.OTG_FS_PWRCLK,
            pin_dm: stm32f4xx_hal::gpio::alt::otg_fs::Dm::PA11(gpioa.pa11.into_alternate()),
            pin_dp: stm32f4xx_hal::gpio::alt::otg_fs::Dp::PA12(gpioa.pa12.into_alternate()),
            hclk: clocks.hclk(),
        };
        *USB_BUS = Some(UsbBusType::new(usb, EP_MEMORY));
        let usb_bus = USB_BUS.as_ref().unwrap();

        let usb_class = keyberon::new_class(usb_bus, ());
        let usb_dev = keyberon::new_device(usb_bus);

        let mut timer = c.device.TIM3.counter_us(&clocks);
        timer.start(1.millis()).unwrap();
        timer.listen(timer::Event::Update);
        unsafe {
            pac::NVIC::unmask(pac::Interrupt::TIM3);
        }

        let delay: DelayUs<TIM5> = c.device.TIM5.delay_us(&clocks);
        let matrix = DelayedMatrix::new(
            [
                gpiob.pb12.into_pull_up_input().erase(), // col1
                gpiob.pb13.into_pull_up_input().erase(), // col2
                gpiob.pb14.into_pull_up_input().erase(), // col3
                gpiob.pb15.into_pull_up_input().erase(), // col4
                gpioa.pa8.into_pull_up_input().erase(),  // col5
                gpioa.pa15.into_pull_up_input().erase(), // col6
                gpioa.pa3.into_pull_up_input().erase(),  // col7
                gpioa.pa4.into_pull_up_input().erase(),  // col8
                gpioa.pa5.into_pull_up_input().erase(),  // col9
                gpioa.pa6.into_pull_up_input().erase(),  // col10
                gpioa.pa7.into_pull_up_input().erase(),  // col11
                gpiob.pb1.into_pull_up_input().erase(),  // col12
            ],
            [
                gpioa.pa10.into_push_pull_output().erase(), // row1
                gpiob.pb5.into_push_pull_output().erase(),  // row2
                gpiob.pb6.into_push_pull_output().erase(),  // row3
                gpiob.pb7.into_push_pull_output().erase(),  // row4
                gpiob.pb8.into_push_pull_output().erase(),  // row5
            ],
            delay,
            5, // select pin delay
            5, // unselect pin delay
        );

        init::LateResources {
            usb_dev,
            usb_class,
            timer,
            // 5x12 debouncer
            debouncer: Debouncer::new([[false; COLS]; ROWS], [[false; COLS]; ROWS], 25),
            matrix: matrix.unwrap(),
            layout: Layout::new(&LAYERS),
            chording: Chording::new(&CHORDS),
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

    #[task(binds = TIM3, priority = 1, resources = [usb_class, matrix, debouncer, layout, chording, timer])]
    fn tick(mut c: tick::Context) {
        c.resources.timer.clear_interrupt(timer::Event::Update);

        let events = c
            .resources
            .debouncer
            .events(c.resources.matrix.get().unwrap());
        let chordEvents = c.resources.chording.tick(events.collect());

        for event in chordEvents
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
