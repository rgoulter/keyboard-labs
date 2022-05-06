use keyberon::action::{d, k, l, m, Action, Action::*, HoldTapConfig};
use keyberon::key_code::KeyCode::*;

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

