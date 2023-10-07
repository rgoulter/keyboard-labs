/// Macro for "shift + key".
#[macro_export]
macro_rules! sk {
    ($k:ident) => {
        keyberon::action::m(&[keyberon::key_code::KeyCode::LShift, $k].as_slice())
    };
}

/// Macro for "tap-hold, with super modifier".
#[macro_export]
macro_rules! s {
    ($k:ident) => {
        keyberon::action::Action::HoldTap(&keyberon::action::HoldTapAction {
            timeout: 200,
            tap_hold_interval: 0,
            config: keyberon::action::HoldTapConfig::Default,
            hold: keyberon::action::k(keyberon::key_code::KeyCode::LShift),
            tap: keyberon::action::k($k),
        })
    };
}

/// Macro for "tap-hold, with ctrl modifier".
#[macro_export]
macro_rules! c {
    ($k:ident) => {
        keyberon::action::Action::HoldTap(&keyberon::action::HoldTapAction {
            timeout: 200,
            tap_hold_interval: 0,
            config: keyberon::action::HoldTapConfig::Default,
            hold: keyberon::action::k(keyberon::key_code::KeyCode::LCtrl),
            tap: keyberon::action::k($k),
        })
    };
}

/// Macro for "tap-hold, with gui modifier".
#[macro_export]
macro_rules! g {
    ($k:ident) => {
        keyberon::action::Action::HoldTap(&keyberon::action::HoldTapAction {
            timeout: 200,
            tap_hold_interval: 0,
            config: keyberon::action::HoldTapConfig::Default,
            hold: keyberon::action::k(keyberon::key_code::KeyCode::LGui),
            tap: keyberon::action::k($k),
        })
    };
}

/// Macro for "tap-hold, with alt modifier".
#[macro_export]
macro_rules! a {
    ($k:ident) => {
        keyberon::action::Action::HoldTap(&keyberon::action::HoldTapAction {
            timeout: 200,
            tap_hold_interval: 0,
            config: keyberon::action::HoldTapConfig::Default,
            hold: keyberon::action::k(keyberon::key_code::KeyCode::LAlt),
            tap: keyberon::action::k($k),
        })
    };
}

pub use sk;
pub use s;
pub use c;
pub use g;
pub use a;
