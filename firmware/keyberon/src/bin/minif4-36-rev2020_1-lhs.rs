#![no_main]
#![no_std]

// set the panic handler
use panic_halt as _;

use keyberon::action::{d, k, l, m, Action, Action::*, HoldTapConfig};
use keyberon::debounce::Debouncer;
use keyberon::key_code::KbHidReport;
use keyberon::key_code::KeyCode::*;
use keyberon::layout::{Event, Layout};
use nb::block;
use rtic::app;
use rtic::Exclusive;
use rtic::Mutex;
use stm32f4xx_hal::otg_fs::{UsbBusType, USB};
use stm32f4xx_hal::prelude::*;
use stm32f4xx_hal::serial;
use stm32f4xx_hal::serial::config::Config;
use stm32f4xx_hal::{stm32, timer};
use usb_device::bus::UsbBusAllocator;
use usb_device::class::UsbClass as _;
use usb_device::device::UsbDeviceState;
use usb_device::prelude::*;

use keyberon_f4_split_dp::direct_pin_matrix_lhs::{
    direct_pin_matrix_for_peripherals_lhs,
    event_transform_lhs,
    DirectPins5x4Lhs,
    PressedKeys5x4,
};

type UsbClass = keyberon::Class<'static, UsbBusType, ()>;

type UsbDevice = usb_device::device::UsbDevice<'static, UsbBusType>;

type UsbSerial = usbd_serial::SerialPort<'static, UsbBusType>;

const NUM_BASE_LAYERS: usize = 2;
const BASE_DSK: usize = 0;
const BASE_QWERTY: usize = 1;
const NAVR: usize = NUM_BASE_LAYERS + 0;
const MOUR: usize = NUM_BASE_LAYERS + 1;
const MEDR: usize = NUM_BASE_LAYERS + 2;
const NSL: usize = NUM_BASE_LAYERS + 3;
const NSSL: usize = NUM_BASE_LAYERS + 4;
const FUNL: usize = NUM_BASE_LAYERS + 5;

const SP_NAVR: Action<()> = HoldTap {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: &l(NAVR),
    tap: &k(Space),
};

const TAB_MOUR: Action<()> = HoldTap {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: &l(MOUR),
    tap: &k(Tab),
};

const ESC_MEDR: Action<()> = HoldTap {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: &l(MEDR),
    tap: &k(Escape),
};

const BKSP_NSL: Action<()> = HoldTap {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: &l(NSL),
    tap: &k(BSpace),
};

const ENT_NSSL: Action<()> = HoldTap {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: &l(NSSL),
    tap: &k(Enter),
};

const DEL_FUNL: Action<()> = HoldTap {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: &l(FUNL),
    tap: &k(Delete),
};

/// Macro for "shift + key".
macro_rules! sk {
    ($k:ident) => {
        m(&[LShift, $k])
    };
}

/// Macro for "tap-hold, with super modifier".
macro_rules! s {
    ($k:ident) => {
        HoldTap {
            timeout: 200,
            tap_hold_interval: 0,
            config: HoldTapConfig::Default,
            hold: &k(LShift),
            tap: &k($k),
        }
    };
}

/// Macro for "tap-hold, with ctrl modifier".
macro_rules! c {
    ($k:ident) => {
        HoldTap {
            timeout: 200,
            tap_hold_interval: 0,
            config: HoldTapConfig::Default,
            hold: &k(LCtrl),
            tap: &k($k),
        }
    };
}

/// Macro for "tap-hold, with gui modifier".
macro_rules! g {
    ($k:ident) => {
        HoldTap {
            timeout: 200,
            tap_hold_interval: 0,
            config: HoldTapConfig::Default,
            hold: &k(LGui),
            tap: &k($k),
        }
    };
}

/// Macro for "tap-hold, with alt modifier".
macro_rules! a {
    ($k:ident) => {
        HoldTap {
            timeout: 200,
            tap_hold_interval: 0,
            config: HoldTapConfig::Default,
            hold: &k(LAlt),
            tap: &k($k),
        }
    };
}

#[rustfmt::skip]
pub static LAYERS: keyberon::layout::Layers<()> = &[
    // layer 0: dsk
    &[
        &[k(Quote),  k(Comma), k(Dot),   k(P),     k(Y),       k(F),     k(G),     k(C),     k(R),  k(L),],
        &[a!(A),     g!(O),    c!(E),    s!(U),    k(I),       k(D),     s!(H),    c!(T),    g!(N), a!(S),],
        &[k(SColon), k(Q),     k(J),     k(K),     k(X),       k(B),     k(M),     k(W),     k(V),  k(Z),],
        &[Trans,     Trans,    TAB_MOUR, ESC_MEDR, SP_NAVR,    BKSP_NSL, ENT_NSSL, DEL_FUNL, Trans, Trans,],
    ],
    // layer 1: qwerty
    &[
        &[k(Q),  k(W),  k(E),     k(R),     k(T),       k(Y),     k(U),     k(I),     k(O),   k(P),     ],
        &[k(A),  k(S),  k(D),     k(F),     k(G),       k(H),     k(J),     k(K),     k(L),   k(SColon),],
        &[k(Z),  k(X),  k(C),     k(V),     k(B),       k(N),     k(M),     k(Comma), k(Dot), k(Slash), ],
        &[Trans, Trans, TAB_MOUR, ESC_MEDR, SP_NAVR,    BKSP_NSL, ENT_NSSL, DEL_FUNL, Trans,  Trans,   ],
    ],
    // 2 nav-r,
    &[
        &[Trans,Trans,Trans,Trans,Trans,    Trans,   Trans,     Trans,   Trans,    Trans,],
        &[Trans,Trans,Trans,Trans,Trans,    k(Left), k(Down),   k(Up),   k(Right), Trans,],
        &[Trans,Trans,Trans,Trans,Trans,    k(Home), k(PgDown), k(PgUp), k(End),   k(Insert),],
        &[Trans,Trans,Trans,Trans,Trans,    Trans,   Trans,     Trans,   Trans,    Trans,],
    ],
    // 3 mouse-r,
    // TBI
    &[
        &[Trans,Trans,Trans,Trans,Trans,    Trans,Trans,Trans,Trans,Trans,],
        &[Trans,Trans,Trans,Trans,Trans,    Trans,Trans,Trans,Trans,Trans,],
        &[Trans,Trans,Trans,Trans,Trans,    Trans,Trans,Trans,Trans,Trans,],
        &[Trans,Trans,Trans,Trans,Trans,    Trans,Trans,Trans,Trans,Trans,],
    ],
    // 4 media-r,
    &[
        &[Trans,Trans,Trans,Trans,Trans,    Trans,                Trans,           Trans,         Trans,            Trans,],
        &[Trans,Trans,Trans,Trans,Trans,    k(MediaPreviousSong), k(MediaVolDown), k(MediaVolUp), k(MediaNextSong), Trans,],
        &[Trans,Trans,Trans,Trans,Trans,    d(BASE_DSK),          d(BASE_QWERTY),  Trans,         Trans,            Trans,],
        &[Trans,Trans,Trans,Trans,Trans,    k(MediaPlayPause),    k(MediaMute),    k(MediaStop),  Trans,            Trans,],
    ],
    // 5 numsym-l,
    &[
        &[k(LBracket), k(Kb7), k(Kb8), k(Kb9), k(RBracket),     Trans,Trans,Trans,Trans,Trans,],
        &[k(Grave),    k(Kb4), k(Kb5), k(Kb6), k(Equal),        Trans,Trans,Trans,Trans,Trans,],
        &[k(Slash),    k(Kb1), k(Kb2), k(Kb3), k(Bslash),       Trans,Trans,Trans,Trans,Trans,],
        &[Trans,       Trans,  k(Dot), k(Kb0), k(Minus),        Trans,Trans,Trans,Trans,Trans,],
    ],
    // 6 shiftednumsym-l,
    &[
        &[sk!(LBracket), sk!(Kb7), sk!(Kb8), sk!(Kb9),    sk!(RBracket),    Trans,Trans,Trans,Trans,Trans,],
        &[sk!(Grave),    sk!(Kb4), sk!(Kb5), sk!(Kb6),    sk!(Equal),       Trans,Trans,Trans,Trans,Trans,],
        &[sk!(Slash),    sk!(Kb1), sk!(Kb2), sk!(Kb3),    sk!(Bslash),      Trans,Trans,Trans,Trans,Trans,],
        &[Trans,         Trans,    sk!(Dot), sk!(Kb0),    sk!(Minus),       Trans,Trans,Trans,Trans,Trans,],
    ],
    // 7 func-l
    &[
        &[k(F12), k(F7), k(F8), k(F9), Trans,    Trans,Trans,Trans,Trans,Trans,],
        &[k(F11), k(F4), k(F5), k(F6), Trans,    Trans,Trans,Trans,Trans,Trans,],
        &[k(F10), k(F1), k(F2), k(F3), Trans,    Trans,Trans,Trans,Trans,Trans,],
        &[Trans,  Trans, Trans, Trans, Trans,    Trans,Trans,Trans,Trans,Trans,],
    ],
];

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
        direct_pins: DirectPins5x4Lhs,
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

        let direct_pins = direct_pin_matrix_for_peripherals_lhs(
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
            gpiob.pb9.into_pull_up_input(),
            gpiob.pb10.into_pull_up_input(),
            gpiob.pb15.into_pull_up_input(),
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
            transform: event_transform_lhs,
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
            .events(c.resources.direct_pins.get_lhs().unwrap())
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

fn usb_poll(
    usb_dev: &mut UsbDevice,
    keyboard: &mut UsbClass,
    usb_serial: &mut impl Mutex<T = UsbSerial>,
) {
    usb_serial.lock(|serial| {
        if usb_dev.poll(&mut [keyboard, serial]) {
            keyboard.poll();
            serial.poll();
        }
    })
}

/// Deserialise a slice of bytes into a keyberon Event.
///
/// The serialisation format must be compatible with
/// the serialisation format in `ser`.
fn de(bytes: &[u8]) -> Result<Event, ()> {
    match *bytes {
        [b'P', i, j, b'\n'] => Ok(Event::Press(i, j)),
        [b'R', i, j, b'\n'] => Ok(Event::Release(i, j)),
        _ => Err(()),
    }
}

/// Serialise a keyberon event into an array of bytes.
///
/// The serialisation format must be compatible with
/// the serialisation format in `de`.
fn ser(e: Event) -> [u8; 4] {
    match e {
        Event::Press(i, j) => [b'P', i, j, b'\n'],
        Event::Release(i, j) => [b'R', i, j, b'\n'],
    }
}
