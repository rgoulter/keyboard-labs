#![no_main]
#![no_std]

// set the panic handler
use panic_halt as _;

use keyberon::debounce::Debouncer;
use keyberon::key_code::KbHidReport;
use keyberon::layout::{Event, Layout};
use nb::block;
use rtic::app;
use rtic::Exclusive;
use stm32f4xx_hal::otg_fs::{UsbBusType, USB};
use stm32f4xx_hal::prelude::*;
use stm32f4xx_hal::serial;
use stm32f4xx_hal::serial::config::Config;
use stm32f4xx_hal::{stm32, timer};
use usb_device::bus::UsbBusAllocator;
use usb_device::device::UsbDeviceState;
use usb_device::prelude::*;

use keyberon_f4_split_dp::common::{
    UsbClass,
    UsbDevice,
    UsbSerial,
    de,
    ser,
    usb_poll,
};
use keyberon_f4_split_dp::direct_pin_matrix::{
    DirectPins,
    PressedKeys5x4,
};
use keyberon_f4_split_dp::layouts::minif4_36::LAYERS;
use keyberon_f4_split_dp::rev2021_1::pin_layout_rhs::{
    DirectPins5x4,
    direct_pin_matrix_for_peripherals,
    event_transform,
};

/// USB VIP for a generic keyboard from
/// https://github.com/obdev/v-usb/blob/master/usbdrv/USB-IDs-for-free.txt
const VID: u16 = 0x16c0;

/// USB PID for a generic keyboard from
/// https://github.com/obdev/v-usb/blob/master/usbdrv/USB-IDs-for-free.txt
const PID: u16 = 0x27db;

// The rtic app for the keyboard firmware.
#[app(device = stm32f4xx_hal::stm32, peripherals = true)]
const APP: () = {
    struct Resources {
        usb_dev: UsbDevice,
        usb_class: UsbClass,
        direct_pins: DirectPins5x4,
        debouncer: Debouncer<PressedKeys5x4>,
        layout: Layout<()>,
        timer: timer::Timer<stm32::TIM3>,
        transform: fn(Event) -> Event,
        tx: serial::Tx<stm32f4xx_hal::stm32::USART1>,
        rx: serial::Rx<stm32f4xx_hal::stm32::USART1>,
        usb_serial: UsbSerial,
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
        let gpioc = c.device.GPIOC.split();

        let usb = USB {
            usb_global: c.device.OTG_FS_GLOBAL,
            usb_device: c.device.OTG_FS_DEVICE,
            usb_pwrclk: c.device.OTG_FS_PWRCLK,
            pin_dm: gpioa.pa11.into_alternate_af10(),
            pin_dp: gpioa.pa12.into_alternate_af10(),
        };
        *USB_BUS = Some(UsbBusType::new(usb, EP_MEMORY));
        let usb_bus = USB_BUS.as_ref().unwrap();

        let usb_class = keyberon::new_class(usb_bus, ());

        let usb_serial = usbd_serial::SerialPort::new(&usb_bus);

        let usb_dev = UsbDeviceBuilder::new(usb_bus, UsbVidPid(VID, PID))
            .manufacturer("Richard Goulter's Keyboard Prototypes")
            .product("Split 36-key MiniF4")
            .serial_number(env!("CARGO_PKG_VERSION"))
            .device_class(usbd_serial::USB_CLASS_CDC)
            .build();

        let mut timer = timer::Timer::tim3(c.device.TIM3, 1.khz(), clocks);
        timer.listen(timer::Event::TimeOut);

        let direct_pins = direct_pin_matrix_for_peripherals(
            gpioa.pa2.into_pull_up_input(),
            gpioa.pa3.into_pull_up_input(),
            gpioa.pa4.into_pull_up_input(),
            gpioa.pa5.into_pull_up_input(),
            gpioa.pa6.into_pull_up_input(),
            gpioa.pa7.into_pull_up_input(),
            gpioa.pa8.into_pull_up_input(),
            gpioa.pa9.into_pull_up_input(),
            gpioa.pa10.into_pull_up_input(),
            gpioa.pa15.into_pull_up_input(),
            gpiob.pb0.into_pull_up_input(),
            gpiob.pb1.into_pull_up_input(),
            gpiob.pb3.into_pull_up_input(),
            gpiob.pb4.into_pull_up_input(),
            gpiob.pb5.into_pull_up_input(),
            gpiob.pb10.into_pull_up_input(),
            gpiob.pb15.into_pull_up_input(),
            gpioc.pc15.into_pull_up_input(),
        );

        let pins = (
            gpiob.pb6.into_alternate_af7(),
            gpiob.pb7.into_alternate_af7(),
        );
        let mut serial = serial::Serial::usart1(
            c.device.USART1,
            pins,
            Config::default().baudrate(9_600.bps()),
            clocks,
        )
        .unwrap();
        serial.listen(serial::Event::Rxne);
        let (tx, rx) = serial.split();

        init::LateResources {
            debouncer: Debouncer::new(PressedKeys5x4::default(), PressedKeys5x4::default(), 5),
            direct_pins: direct_pins,
            layout: Layout::new(LAYERS),
            rx,
            timer,
            transform: event_transform,
            tx,
            usb_class,
            usb_dev,
            usb_serial,
        }
    }

    /// Handle input from the TRRS cable.
    ///
    /// Spawns keyberon Events for each message that
    /// can be deserialised from UART1.
    ///
    /// This is how the split-half which isn't connected to
    /// the computer with USB can still have its key presses
    /// sent to the computer.
    #[task(binds = USART1, priority = 5, spawn = [handle_event], resources = [rx])]
    fn rx(c: rx::Context) {
        static mut BUF: [u8; 4] = [0; 4];

        if let Ok(b) = c.resources.rx.read() {
            BUF.rotate_left(1);
            BUF[3] = b;

            if BUF[3] == b'\n' {
                if let Ok(event) = de(&BUF[..]) {
                    c.spawn.handle_event(Some(event)).unwrap();
                }
            }
        }
    }

    /// Poll the USB device for the OTG_FS interrupt.
    #[task(binds = OTG_FS, priority = 4, resources = [usb_class, usb_dev, usb_serial])]
    fn usb_tx(mut c: usb_tx::Context) {
        usb_poll(
            &mut c.resources.usb_dev,
            &mut c.resources.usb_class,
            &mut Exclusive(c.resources.usb_serial),
        );
    }

    /// Poll the USB device for the OTG_FS_WKUP interrupt.
    #[task(binds = OTG_FS_WKUP, priority = 4, resources = [usb_class, usb_dev, usb_serial])]
    fn usb_rx(mut c: usb_rx::Context) {
        usb_poll(
            &mut c.resources.usb_dev,
            &mut c.resources.usb_class,
            &mut Exclusive(c.resources.usb_serial),
        );
    }

    /// Handles keyberon Events and sends the resulting HID report
    /// to the computer.
    ///
    /// When `event` is Some(event), the keyberon layout is
    /// updated with this event. When `event` is None,
    /// a layout tick occurs and the resulting report is written.
    /// i.e. this task should be spawned with None as the event
    /// every tick.
    #[task(priority = 3, capacity = 8, resources = [layout, usb_class, usb_dev])]
    fn handle_event(mut c: handle_event::Context, event: Option<Event>) {
        match event {
            None => {
                c.resources.layout.tick();

                // Update the usb keyboard with the HID report from the
                // keyberon layout.
                let report: KbHidReport = c.resources.layout.keycodes().collect();
                if !c
                    .resources
                    .usb_class
                    .lock(|k| k.device_mut().set_keyboard_report(report.clone()))
                {
                    return;
                }
                // Check the USB connection is in a good state.
                if c.resources.usb_dev.lock(|d| d.state()) != UsbDeviceState::Configured {
                    return;
                }
                // Write the report to the usb keyboard class.
                while let Ok(0) = c.resources.usb_class.lock(|k| k.write(report.as_bytes())) {}
            }
            Some(e) => {
                // Update the keyberon layout state with the event.
                c.resources.layout.event(e);
            }
        };
    }

    #[task(
        binds = TIM3,
        priority = 2,
        spawn = [handle_event],
        resources = [
            debouncer,
            direct_pins,
            layout,
            timer,
            &transform,
            tx,
            usb_class,
            usb_serial
        ]
    )]
    fn tick(c: tick::Context) {
        c.resources.timer.clear_interrupt(timer::Event::TimeOut);

        // Construct the keyberon events by reading from the gpio
        // pins, debouncing the inputs, and transforming the values
        // for left/right-hand split half.
        for event in c
            .resources
            .debouncer
            .events(c.resources.direct_pins.get().unwrap())
            .map(c.resources.transform)
        {
            // Send the event across the TRRS cable.
            for &b in &ser(event) {
                block!(c.resources.tx.write(b)).unwrap();
            }
            block!(c.resources.tx.flush()).unwrap();

            // update the keyberon layout with the event.
            c.spawn.handle_event(Some(event)).unwrap();
        }
        // update the keyberon layout & send the HID report to the computer.
        c.spawn.handle_event(None).unwrap();
    }

    extern "C" {
        // An otherwise unused interrupt.
        // Used by rtic for the handle_event software task.
        fn TIM2();
    }
};
