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

// Columns = 10
// Rows = 4
// Layers = 8
// Custom action type = ()
pub type Layers = keyberon::layout::Layers<10, 4, 8, ()>;
pub type Layout = keyberon::layout::Layout<10, 4, 8, ()>;

#[rustfmt::skip]
pub static LAYERS: Layers = keyberon::layout::layout! {
    // layer 0: dsk
    {
        [{k(Quote) } ,         .         P         Y           F         G         C         R      L     ],
        [{a!(A)    }{g!(O)   }{c!(E) }  {s!(U)}    I           D        {s!(H)}   {c!(T)}   {g!(N)}{a!(S)}],
        [ ;          Q         J         K         X           B         M         W         V      Z     ],
        [ t          t        {TAB_MOUR}{ESC_MEDR}{SP_NAVR}   {BKSP_NSL}{ENT_NSSL}{DEL_FUNL} t      t     ],
    }
    // layer 1: qwerty
    {
        [Q      W         E         R         T           Y         U         I         O       P       ],
        [A      S         D         F         G           H         J         K         L       ;       ],
        [Z      X         C         V         B           N         M         ,         .       /       ],
        [t      t        {TAB_MOUR}{ESC_MEDR}{SP_NAVR}   {BKSP_NSL}{ENT_NSSL}{DEL_FUNL} t       t       ],
    }
    // 2 nav-r,
    {
        [t     t     t     t     t         t        t          t        t         t     ],
        [t     t     t     t     t         Left     Down       Up       Right     t     ],
        [t     t     t     t     t         Home     PgDown     PgUp     End       Insert],
        [t     t     t     t     t         t        t          t        t         t     ],
    }
    // 3 mouse-r,
    // TBI
    {
        [t     t     t     t     t         t     t     t     t     t     ],
        [t     t     t     t     t         t     t     t     t     t     ],
        [t     t     t     t     t         t     t     t     t     t     ],
        [t     t     t     t     t         t     t     t     t     t     ],
    }
    // 4 media-r,
    {
        [t     t     t     t     t         t                     t                t              t                 t     ],
        [t     t     t     t     t        {k(MediaPreviousSong)}{k(MediaVolDown)}{k(MediaVolUp)}{k(MediaNextSong)} t     ],
        [t     t     t     t     t        {d(BASE_DSK)         }{d(BASE_QWERTY) } t              t                 t     ],
        [t     t     t     t     t        {k(MediaPlayPause)   }{k(MediaMute)   }{k(MediaStop) } t                 t     ],
    }
    // 5 numsym-l,
    {
        [{k(LBracket)}{k(Kb7)}{k(Kb8)}{k(Kb9)}{k(RBracket)}     t     t     t     t     t     ],
        [{k(Grave)   }{k(Kb4)}{k(Kb5)}{k(Kb6)}{k(Equal)   }     t     t     t     t     t     ],
        [{k(Slash)   }{k(Kb1)}{k(Kb2)}{k(Kb3)}{k(Bslash)  }     t     t     t     t     t     ],
        [ t            t       .      {k(Kb0)}{k(Minus)   }     t     t     t     t     t     ],
    }
    // 6 shiftednumsym-l,
    {
        [{sk!(LBracket)}{sk!(Kb7)}{sk!(Kb8)}{sk!(Kb9)}         {sk!(RBracket)}    t     t     t     t     t     ],
        [{sk!(Grave)   }{sk!(Kb4)}{sk!(Kb5)}{sk!(Kb6)}         {sk!(Equal)   }    t     t     t     t     t     ],
        [{sk!(Slash)   }{sk!(Kb1)}{sk!(Kb2)}{sk!(Kb3)}         {sk!(Bslash)  }    t     t     t     t     t     ],
        [ t               t       {sk!(Dot)}{sk!(Kb0)}         {sk!(Minus)   }    t     t     t     t     t     ],
    }
    // 7 func-l
    {
        [F12     F7     F8     F9     t         t     t     t     t     t     ],
        [F11     F4     F5     F6     t         t     t     t     t     t     ],
        [F10     F1     F2     F3     t         t     t     t     t     t     ],
        [t       t      t      t      t         t     t     t     t     t     ],
    }
};
