use keyberon::action::{d, k, l, Action::*, HoldTapConfig};
use keyberon::chording::ChordDef;
use usbd_human_interface_device::page::Keyboard::*;

use crate::layouts::actions::{LINUX_DESKTOP_LEFT, LINUX_DESKTOP_RIGHT};
use crate::layouts::common;

use common::{Action, HoldTapAction};

const NUM_BASE_LAYERS: usize = 3;
const BASE_DSK: usize = 0;
const BASE_QWERTY: usize = 1;
const BASE_GAMING: usize = 2;
const LOWER: usize = NUM_BASE_LAYERS;
const LOWER2: usize = NUM_BASE_LAYERS + 1;
const RAISE: usize = NUM_BASE_LAYERS + 2;
const RAISE2: usize = NUM_BASE_LAYERS + 3;
const CHILDPROOF: usize = NUM_BASE_LAYERS + 4;
const NUMPAD: usize = NUM_BASE_LAYERS + 5;
const ADJUST: usize = NUM_BASE_LAYERS + 6;
const FN: usize = NUM_BASE_LAYERS + 7;

const LWR_TAB: Action = HoldTap(&HoldTapAction {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: l(LOWER),
    tap: k(Tab),
});

const LW2_ESC: Action = HoldTap(&HoldTapAction {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: l(LOWER2),
    tap: k(Escape),
});

const RS2_BSP: Action = HoldTap(&HoldTapAction {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: l(RAISE2),
    tap: k(DeleteBackspace),
});

const RSE_ENT: Action = HoldTap(&HoldTapAction {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: l(RAISE),
    tap: k(ReturnEnter),
});

const LWR_ESC: Action = HoldTap(&HoldTapAction {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: l(LOWER),
    tap: k(Escape),
});

pub const COLS: usize = 12;
pub const ROWS: usize = 5;
pub const ROWS_AND_CHORDS: usize = ROWS + 1;
pub const NUM_LAYERS: usize = 11;

pub type Layers = common::Layers<COLS, ROWS_AND_CHORDS, NUM_LAYERS>;
pub type Layout = common::Layout<COLS, ROWS_AND_CHORDS, NUM_LAYERS>;
pub type KeyboardBackend = common::KeyboardBackend<COLS, ROWS_AND_CHORDS, NUM_LAYERS>;

const _______: Action = keyberon::action::Action::Trans;

#[rustfmt::skip]
pub static LAYERS: Layers = [
    // 0: Dvorak
    [
        [k(Keyboard1), k(Keyboard2), k(Keyboard3), k(Keyboard4), k(Keyboard5), k(Grave), k(DeleteBackspace), k(Keyboard6), k(Keyboard7), k(Keyboard8), k(Keyboard9), k(Keyboard0)],
        [k(Apostrophe), k(Comma), k(Dot), k(P), k(Y), NoOp, NoOp, k(F), k(G), k(C), k(R), k(L)],
        [a!(A), g!(O), c!(E), s!(U), k(I), NoOp, NoOp, k(D),  s!(H), c!(T), g!(N), a!(S)],
        [k(Semicolon), k(Q), k(J), k(K), k(X), NoOp, NoOp, k(B), k(M), k(W), k(V), k(Z)],
        [l(NUMPAD), l(FN), NoOp, LWR_TAB, LW2_ESC, k(Space), k(Space), RS2_BSP, RSE_ENT, NoOp, NoOp, NoOp],
        // Combos:
        [LINUX_DESKTOP_LEFT, LINUX_DESKTOP_RIGHT, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp],
    ],

    // 1: QWERTY
    [
        [k(Keyboard1), k(Keyboard2), k(Keyboard3), k(Keyboard4), k(Keyboard5), k(Grave), k(DeleteBackspace), k(Keyboard6), k(Keyboard7), k(Keyboard8), k(Keyboard9), k(Keyboard0)],
        [k(Q), k(W), k(E), k(R), k(T), k(Tab), k(LeftBrace), k(Y), k(U), k(I), k(O), k(P)],
        [k(A), k(S), k(D), k(F), k(G), k(Escape), k(Apostrophe), k(H), k(J), k(K), k(L), k(Semicolon)],
        [k(Z), k(X), k(C), k(V), k(B), k(LeftShift), NoOp, k(N), k(M), k(Comma), k(Dot), k(ForwardSlash)],
        [l(NUMPAD), NoOp, NoOp, LWR_TAB, LW2_ESC, k(Space), k(Space), RS2_BSP, RSE_ENT, NoOp, NoOp, NoOp],
        // Combos:
        [NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp],
    ],

    // 2: Gaming
    [
        [k(Grave), k(Keyboard1), k(Keyboard2), k(Keyboard3), k(Keyboard4), k(Keyboard5), k(Keyboard6), k(Keyboard7), k(Keyboard8), k(Keyboard9), k(Keyboard0), k(DeleteBackspace)],
        [k(Tab), k(Q), k(W), k(E), k(R), k(T), k(Y), k(U), k(I), k(O), k(P), k(LeftBrace)],
        [k(CapsLock), k(A), k(S), k(D), k(F), k(G), k(H), k(J), k(K), k(L), k(Semicolon), k(Apostrophe)],
        [k(LeftShift), k(Z), k(X), k(C), k(V), k(B), k(N), k(M), k(Comma), k(Dot), k(ForwardSlash), k(Backslash)],
        [k(LeftControl), k(LeftGUI), k(LeftAlt), k(Tab), LWR_ESC, k(Space), k(DeleteBackspace), RSE_ENT, k(LeftArrow), k(DownArrow), k(UpArrow), k(RightArrow)],
        // Combos:
        [NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp],
    ],

    // 3: Lower
    [
        [_______,           _______,        _______,        _______,        _______,        _______,    _______,              _______,        _______, _______, _______,      _______],
        [sk!(Keyboard1),    sk!(Keyboard2), sk!(Keyboard3), sk!(Keyboard4), sk!(Keyboard5), sk!(Grave), sk!(DeleteBackspace), sk!(Keyboard6), sk!(Keyboard7), sk!(Keyboard8), sk!(Keyboard9),    sk!(Keyboard0)],
        [sk!(Grave),        _______,        _______,        _______,        _______,        k(Insert),  sk!(ForwardSlash),           k(Insert),      sk!(Minus),      sk!(Equal),    sk!(LeftBrace),    sk!(RightBrace)],
        [sk!(ForwardSlash), _______,        _______,        _______,        sk!(Backslash), _______,     _______,             _______,        _______,         _______,       sk!(ForwardSlash), sk!(Backslash)],
        [_______,           _______,        _______,        _______,        _______,        _______,     _______,             _______,        l(ADJUST),       _______,       _______,           _______],
        // Combos:
        [NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp],
    ],

    // 4: Lower2
    [
        [_______, _______, _______, _______, _______,        _______, _______, _______,      _______,      _______,    _______, _______],
        [k(F12),  k(F7),   k(F8),   k(F9),   k(PrintScreen), _______, _______, _______,      _______,      _______,    _______, _______],
        [k(F11),  k(F4),   k(F5),   k(F6),   k(ScrollLock),  _______, _______, k(LeftArrow), k(DownArrow), k(UpArrow), k(RightArrow), _______],
        [k(F10),  k(F1),   k(F2),   k(F3),   k(Pause),       _______, _______, k(Home),      k(PageDown),  k(PageUp),  k(End),        _______],
        [_______, _______, _______, _______, _______,        _______, _______, _______,      _______,      _______,    _______, _______],
        // Combos:
        [NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp],
    ],

    // // 5: Raise
    [
        [_______,         _______,      _______,      _______,      _______,      _______,   _______,            _______,      _______, _______, _______,      _______],
        [k(Keyboard1),    k(Keyboard2), k(Keyboard3), k(Keyboard4), k(Keyboard5), k(Grave),  k(DeleteForward), k(Keyboard6), k(Keyboard7), k(Keyboard8), k(Keyboard9),    k(Keyboard0)],
        [k(Grave),        _______,      _______,      _______,      _______,      k(DeleteForward), k(ForwardSlash),           k(DeleteForward),    k(Minus),     k(Equal),     k(LeftBrace),    k(RightBrace)],
        [k(ForwardSlash), _______,      _______,      _______,      k(Backslash), _______,   _______,            _______,      _______,      _______,      k(ForwardSlash), k(Backslash)],
        [_______,         _______,      _______,      _______,      _______,      _______,   _______,            _______,      l(ADJUST),    _______,      _______,         _______],
        // Combos:
        [NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp],
    ],

    // 6: Raise2
    // TBI: mouse movement
    [
        [_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______],
        // Combos:
        [NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp],
    ],

    // 7: Childproof
    [
        [NoOp,     NoOp, NoOp, NoOp, NoOp, NoOp,    NoOp, NoOp, NoOp, NoOp, NoOp, NoOp    ],
        [NoOp,     NoOp, NoOp, NoOp, NoOp, NoOp,    NoOp, NoOp, NoOp, NoOp, NoOp, NoOp    ],
        [NoOp,     NoOp, NoOp, NoOp, NoOp, NoOp,    NoOp, NoOp, NoOp, NoOp, NoOp, NoOp    ],
        [NoOp,     NoOp, NoOp, NoOp, NoOp, NoOp,    NoOp, NoOp, NoOp, NoOp, NoOp, NoOp    ],
        [l(LOWER), NoOp, NoOp, NoOp, NoOp, NoOp,    NoOp, NoOp, NoOp, NoOp, NoOp, l(RAISE)],
        // Combos:
        [NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp],
    ],

    // 8: Numpad
    // Swap the macro on left/right.
    [
        [_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______],
        [k(KeypadNumLockAndClear), k(Keypad7), k(Keypad8), k(Keypad9), _______, _______, _______, _______, _______, _______, _______, _______],
        [_______,    k(Keypad4), k(Keypad5), k(Keypad6), _______, _______, _______, _______, _______, _______, _______, _______],
        [_______,    k(Keypad1), k(Keypad2), k(Keypad3), _______, _______, _______, _______, _______, _______, _______, _______],
        [_______,    k(Keypad0), k(Keypad0), k(KeypadDot), _______, _______, _______, _______, _______, _______, _______, _______],
        // Combos:
        [LINUX_DESKTOP_RIGHT, LINUX_DESKTOP_LEFT, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp],
    ],

    // // 9: Adjust
    [
        [NoOp,        NoOp, NoOp, NoOp, NoOp, NoOp,    NoOp, NoOp, NoOp,           NoOp,           NoOp,        NoOp],
        [NoOp,        NoOp, NoOp, NoOp, NoOp, NoOp,    NoOp, NoOp, NoOp,           NoOp,           NoOp,        NoOp],
        [k(CapsLock), NoOp, NoOp, NoOp, NoOp, NoOp,    NoOp, NoOp, d(BASE_QWERTY), d(BASE_GAMING), d(BASE_DSK), d(CHILDPROOF)],
        [NoOp,        NoOp, NoOp, NoOp, NoOp, NoOp,    NoOp, NoOp, NoOp,           NoOp,           NoOp,        NoOp],
        [NoOp,        NoOp, NoOp, NoOp, NoOp, NoOp,    NoOp, NoOp, NoOp,           NoOp,           NoOp,        NoOp],
        // Combos:
        [NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp],
    ],

    // 10: Fn
    [
        [_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______],
        [_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______],
        // Combos:
        [NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp, NoOp],
    ],
];

pub const NUM_CHORDS: usize = 2;
pub const CHORDS: [ChordDef; NUM_CHORDS] = [
    ((5, 0), &[(3, 2), (3, 3)]), // JK -> Desktop Left
    ((5, 1), &[(3, 8), (3, 9)]), // M, -> Desktop Right
];
