use keyberon::action::{Action::*, HoldTapConfig, d, k, l};
use keyberon::chording::ChordDef;
use usbd_human_interface_device::page::{Keyboard::*, Keyboard};

use crate::layouts::common::{Action, CustomAction, HoldTapAction};

const NUM_BASE_LAYERS: usize = 2;
const BASE_DSK: usize = 0;
const BASE_QWERTY: usize = 1;
const NAVR: usize = NUM_BASE_LAYERS + 0;
const MOUR: usize = NUM_BASE_LAYERS + 1;
const MEDR: usize = NUM_BASE_LAYERS + 2;
const NSL: usize = NUM_BASE_LAYERS + 3;
const NSSL: usize = NUM_BASE_LAYERS + 4;
const FUNL: usize = NUM_BASE_LAYERS + 5;

const SP_NAVR: Action = HoldTap(&HoldTapAction {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: l(NAVR),
    tap: k(Space),
});

const TAB_MOUR: Action = HoldTap(&HoldTapAction {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: l(MOUR),
    tap: k(Tab),
});

const ESC_MEDR: Action = HoldTap(&HoldTapAction {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: l(MEDR),
    tap: k(Escape),
});

const BKSP_NSL: Action = HoldTap(&HoldTapAction {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: l(NSL),
    tap: k(DeleteBackspace),
});

const ENT_NSSL: Action = HoldTap(&HoldTapAction {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: l(NSSL),
    tap: k(ReturnEnter),
});

const DEL_FUNL: Action = HoldTap(&HoldTapAction {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: l(FUNL),
    tap: k(DeleteForward),
});

pub const COLS: usize = 2 * 5;
pub const ROWS: usize = 4;
pub const ROWS_AND_MACROS: usize = ROWS + 0;
pub const NUM_LAYERS: usize = 8;

pub type Layers = keyberon::layout::Layers<COLS, ROWS, NUM_LAYERS, CustomAction, Keyboard>;
pub type Layout = keyberon::layout::Layout<COLS, ROWS, NUM_LAYERS, CustomAction, Keyboard>;

const _______: Action = keyberon::action::Action::Trans;

#[rustfmt::skip]
pub static LAYERS: Layers = [
    // 0: Dvorak
    [
        [k(Apostrophe), k(Comma), k(Dot), k(P), k(Y), k(F), k(G), k(C), k(R), k(L)],
        [a!(A), g!(O), c!(E), s!(U), k(I), k(D), s!(H), c!(T), g!(N), a!(S)],
        [k(Semicolon), k(Q), k(J), k(K), k(X), k(B), k(M), k(W), k(V), k(Z)],
        [_______, _______, TAB_MOUR, ESC_MEDR, SP_NAVR,  BKSP_NSL, ENT_NSSL, DEL_FUNL, _______, _______],
    ],
    // 1: QWERTY
    [
        [k(Q), k(W), k(E), k(R), k(T), k(Y), k(U), k(I), k(O), k(P)],
        [k(A), k(S), k(D), k(F), k(G), k(H), k(J), k(K), k(L), k(Semicolon)],
        [k(Z), k(X), k(C), k(V), k(B), k(N), k(M), k(Comma), k(Dot), k(ForwardSlash)],
        [_______, _______, TAB_MOUR, ESC_MEDR, SP_NAVR,  BKSP_NSL, ENT_NSSL, DEL_FUNL, _______, _______],
    ],
    // 2 nav-r,
    [
        [_______, _______, _______, _______, _______,   _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______,   k(LeftArrow), k(DownArrow), k(UpArrow), k(RightArrow), _______],
        [_______, _______, _______, _______, _______,   k(Home), k(PageDown), k(PageUp), k(End), k(Insert)],
        [_______, _______, _______, _______, _______,   _______, _______, _______, _______, _______],
    ],
    // 3 mouse-r,
    // TBI
    [
        [_______, _______, _______, _______, _______,   _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______,   _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______,   _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______,   _______, _______, _______, _______, _______],
    ],
    // 4 media-r,
    [
        [_______, _______, _______, _______, _______,   _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______,   _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______,   d(BASE_DSK), d(BASE_QWERTY), _______, _______, _______],
        [_______, _______, _______, _______, _______,   _______, _______, _______, _______, _______],
    ],
    // 5 numsym-l,
    [
        [k(LeftBrace), k(Keyboard7), k(Keyboard8), k(Keyboard9), k(RightBrace),   _______, _______, _______, _______, _______],
        [k(Grave),    k(Keyboard4), k(Keyboard5), k(Keyboard6), k(Equal),   _______, _______, _______, _______, _______],
        [k(ForwardSlash),    k(Keyboard1), k(Keyboard2), k(Keyboard3), k(Backslash),   _______, _______, _______, _______, _______],
        [_______, _______, k(Dot), k(Keyboard0), k(Minus),   _______, _______, _______, _______, _______],
    ],
    // 6 shiftednumsym-l,
    [
        [sk!(LeftBrace), sk!(Keyboard7), sk!(Keyboard8), sk!(Keyboard9), sk!(RightBrace),   _______, _______, _______, _______, _______],
        [sk!(Grave),    sk!(Keyboard4), sk!(Keyboard5), sk!(Keyboard6), sk!(Equal),   _______, _______, _______, _______, _______],
        [sk!(ForwardSlash),    sk!(Keyboard1), sk!(Keyboard2), sk!(Keyboard3), sk!(Backslash),   _______, _______, _______, _______, _______],
        [_______, _______, sk!(Dot), sk!(Keyboard0), sk!(Minus),   _______, _______, _______, _______, _______],
    ],
    // 7 func-l
    [
        [k(F12), k(F7), k(F8), k(F2), _______,   _______, _______, _______, _______, _______],
        [k(F11), k(F4), k(F5), k(F6), _______,   _______, _______, _______, _______, _______],
        [k(F10), k(F2), k(F2), k(F3), _______,   _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______,   _______, _______, _______, _______, _______],
    ],
];

pub const NUM_CHORDS: usize = 0;
pub const CHORDS: [ChordDef; NUM_CHORDS] = [];
