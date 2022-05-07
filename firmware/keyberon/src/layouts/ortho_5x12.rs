use keyberon::action::{d, k, l, m, Action::*, HoldTapConfig};
use keyberon::chording::ChordDef;
use keyberon::key_code::KeyCode::*;

use crate::layouts::actions::{
    LINUX_DESKTOP_LEFT,
    LINUX_DESKTOP_RIGHT,
};

type Action = keyberon::action::Action<()>;

// const CUT: Action = m(&[LShift, Delete]);
// const COPY: Action = m(&[LCtrl, Insert]);
// const PASTE: Action = m(&[LShift, Insert]);

const NUM_BASE_LAYERS: usize = 3;
const BASE_DSK: usize    = 0;
const BASE_QWERTY: usize = 1;
const BASE_GAMING: usize = 2;
const LOWER: usize      = NUM_BASE_LAYERS + 0;
const LOWER2: usize     = NUM_BASE_LAYERS + 1;
const RAISE: usize      = NUM_BASE_LAYERS + 2;
const RAISE2: usize     = NUM_BASE_LAYERS + 3;
const CHILDPROOF: usize = NUM_BASE_LAYERS + 4;
const NUMPAD: usize     = NUM_BASE_LAYERS + 5;
const ADJUST: usize     = NUM_BASE_LAYERS + 6;
const FN: usize         = NUM_BASE_LAYERS + 7;

// TBI:  FN,      _______, _______, LWR_TAB, LW2_ESC, KC_SPC,    KC_SPC, RS2_BSP, RSE_ENT, _______, _______, _______

const LWR_TAB: Action = HoldTap {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: &l(LOWER),
    tap:  &k(Tab),
};

const LW2_ESC: Action = HoldTap {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: &l(LOWER2),
    tap:  &k(Escape),
};

const RS2_BSP: Action = HoldTap {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: &l(RAISE2),
    tap:  &k(BSpace),
};

const RSE_ENT: Action = HoldTap {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: &l(RAISE),
    tap:  &k(Enter),
};

const LWR_ESC: Action = HoldTap {
    timeout: 200,
    config: HoldTapConfig::Default,
    tap_hold_interval: 0,
    hold: &l(LOWER),
    tap:  &k(Escape),
};

// Columns = 12
// Rows = 5 physical + 1 virtual for chords
// Layers = 11
// Custom action type = ()
pub type Layers = keyberon::layout::Layers<12, 6, 11, ()>;
pub type Layout = keyberon::layout::Layout<12, 6, 11, ()>;

#[rustfmt::skip]
pub static LAYERS: Layers = keyberon::layout::layout! {
    // 0: Dvorak
    {
        [ 1          2         3       4        5        Grave    BSpace 6        7        8      9      0     ],
        [{k(Quote) } ,         .       P        Y       {NoOp}   {NoOp}  F        G        C      R      L     ],
        [{a!(A)    }{g!(O)   }{c!(E) }{s!(U)}   I       {NoOp}   {NoOp}  D       {s!(H)  }{c!(T)}{g!(N)}{a!(S)}],
        [ ;          Q         J       K        X       {NoOp}   {NoOp}  B        M        W      V      Z     ],
        [{l(NUMPAD)}{l(FN)}    t      {LWR_TAB}{LW2_ESC} Space    Space {RS2_BSP}{RSE_ENT} t      t      t     ],
        [{LINUX_DESKTOP_LEFT}{LINUX_DESKTOP_RIGHT}{NoOp}{NoOp}{NoOp}{NoOp}  {NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}],
    }

    // 1: QWERTY
    {
        [ 1          2         3       4        5        Grave     BSpace 6        7        8      9      0    ],
        [ Q          W         E       R        T        Tab       '['    Y        U        I      O      P    ],
        [ A          S         D       F        G        Escape    '\''   H        J        K      L      ;    ],
        [ Z          X         C       V        B        LShift   {NoOp}  N        M        ,      .      /    ],
        [{l(NUMPAD)} t         t      {LWR_TAB}{LW2_ESC} Space     Space {RS2_BSP}{RSE_ENT} t      t      t    ],
        [{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}  {NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}],
    }

    // 2: Gaming
    {
        [Grave     1         2         3       4        5        6        7          8      9      0    BSpace],
        [Tab       Q         W         E       R        T        Y        U          I      O      P    '[' ],
        [CapsLock  A         S         D       F        G        H        J          K      L      ;    '\''],
        [LShift    Z         X         C       V        B        N        M          ,      .      /    '\\'],
        [LCtrl     LGui      LAlt      Tab    {LWR_ESC} Space    BSpace  {RSE_ENT}   Left   Down   Up   Right],
        [{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}  {NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}],
    }

    // 3: Lower
    {
        [ t           t         t         t         t            t               t            t         t           t           t           t           ],
        [{sk!(Kb1)  }{sk!(Kb2)}{sk!(Kb3)}{sk!(Kb4)}{sk!(Kb5)   }{sk!(Grave)}    {sk!(Bslash)}{sk!(Kb6)}{sk!(Kb7)  }{sk!(Kb8)  }{sk!(Kb9)  }{sk!(Kb0)   }],
        [{sk!(Grave)} t         t         t         t            Insert         {sk!(Slash) } Insert   {sk!(Minus)}{sk!(Equal)} '['         ']'         ],
        [{sk!(Slash)} t         t         t        {sk!(Bslash)} t               t            t         t           t          {sk!(Slash)}{sk!(Bslash)}],
        [ t           t         t         t         t            t               t            t        {l(ADJUST)}  t           t           t           ],
        [{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}  {NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}],
    }

    // 4: Lower2
    {
        [t   t  t  t  t          t    t t    t      t    t     t],
        [F12 F7 F8 F9 PScreen    t    t t    t      t    t     t],
        [F11 F4 F5 F6 ScrollLock t    t Left Down   Up   Right t],
        [F10 F1 F2 F3 Pause      t    t Home PgDown PgUp End   t],
        [t   t  t  t  t          t    t t    t      t    t     t],
        [{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}  {NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}],
    }

    // 5: Raise
    {
        [t     t t  t          t      t         t      t t     t     t     t     ],
        [1     2 3  4          5      Grave     BSpace 6 7     8     9     0     ],
        [t     t t  t          t      Delete    t      t Minus Equal '['   ']'   ],
        [Slash t t  t          Bslash t         t      t t     t     Slash Bslash],
        [t     t t {l(ADJUST)} t      t         t      t t     t     t     t     ],
        [{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}  {NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}],
    }

    // 6: Raise2
    // TBI: mouse movement
    {
        [t t t t t t    t t t t t t],
        [t t t t t t    t t t t t t],
        [t t t t t t    t t t t t t],
        [t t t t t t    t t t t t t],
        [t t t t t t    t t t t t t],
        [{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}  {NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}],
    }

    // 7: Childproof
    {
        [{NoOp    } {NoOp} {NoOp} {NoOp} {NoOp} {NoOp}    {NoOp} {NoOp} {NoOp} {NoOp} {NoOp} {NoOp    }],
        [{NoOp    } {NoOp} {NoOp} {NoOp} {NoOp} {NoOp}    {NoOp} {NoOp} {NoOp} {NoOp} {NoOp} {NoOp    }],
        [{NoOp    } {NoOp} {NoOp} {NoOp} {NoOp} {NoOp}    {NoOp} {NoOp} {NoOp} {NoOp} {NoOp} {NoOp    }],
        [{NoOp    } {NoOp} {NoOp} {NoOp} {NoOp} {NoOp}    {NoOp} {NoOp} {NoOp} {NoOp} {NoOp} {NoOp    }],
        [{l(LOWER)} {NoOp} {NoOp} {NoOp} {NoOp} {NoOp}    {NoOp} {NoOp} {NoOp} {NoOp} {NoOp} {l(RAISE)}],
        [{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}  {NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}],
    }

    // 8: Numpad
    {
        [t t   t   t   t t    t t t t t t],
        [t Kp7 Kp8 Kp9 t t    t t t t t t],
        [t Kp4 Kp5 Kp6 t t    t t t t t t],
        [t Kp1 Kp2 Kp3 t t    t t t t t t],
        [t Kp0 Kp0 .   t t    t t t t t t],
        [{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}  {NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}],
    }

    // 9: Adjust
    {
        [t t t t t t    t t t t t t],
        [t t t t t t    t t t t t t],
        [t t t t t t    t t {d(BASE_QWERTY)}{d(BASE_GAMING)}{d(BASE_DSK)}{d(CHILDPROOF)}],
        [t t t t t t    t t t t t t],
        [t t t t t t    t t t t t t],
        [{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}  {NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}],
    }
    // Pinky-outer-column
    // [_ADJUST] = LAYOUT(
    //     KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,      KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,       \
    //     _______, RESET,   _______, _______, _______, _______,    _______, _______, _______, _______, _______, KC_DEL,       \
    //     KC_CAPS, DM_REC2, DM_REC1, DM_PLY2, DM_PLY1, DM_RSTP,    _______, QWERTY,  GAMING,  DVORAK,  CHILDPROOF,  _______,  \
    //     _______, _______, OSWIN,   OSMACOS, OSLINUX, _______,    _______, _______, KC_BTN1, KC_BTN2, KC_WH_D, KC_WH_U,     \
    //     _______, _______, _______, _______, _______, _______,    _______, _______, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R      \
    // ),

    // 10: Fn
    {
        [t t t t t t    t t t t t t],
        [t t t t t t    t t t t t t],
        [t t t t t t    t t t t t t],
        [t t t t t t    t t t t t t],
        [t t t t t t    t t t t t t],
        [{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}  {NoOp}{NoOp}{NoOp}{NoOp}{NoOp}{NoOp}],
    }
    // Same as default layer
    // [_FN] = LAYOUT(
    //     _______, _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______, _______,
    //     _______, _______, _______, _______, _______, _______,    _______, _______, _______, RGB_VAD, RGB_VAI, _______,
    //     _______, _______, _______, _______, _______, _______,    _______, _______, _______, RGB_SAD, RGB_SAI, _______,
    //     _______, _______, _______, _______, _______, _______,    _______, _______, RGB_TOG, RGB_HUD, RGB_HUI, RGB_MOD,
    //     _______, _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______, _______
    // )
};

pub const CHORDS: [ChordDef; 2] = [
    ((5, 0), &[(3, 2), (3, 3)]), // JK -> Desktop Left
    ((5, 1), &[(3, 8), (3, 9)]), // M, -> Desktop Right
];

