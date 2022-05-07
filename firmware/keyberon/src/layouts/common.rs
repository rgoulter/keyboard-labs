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
