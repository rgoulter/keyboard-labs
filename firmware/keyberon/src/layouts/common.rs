// macro_rules! doesn't like using these types directly
// beause of the comma in the type specifier.
// So, use these types instead.

pub type Action = keyberon::action::Action<(), usbd_human_interface_device::page::Keyboard>;
pub type HoldTapAction = keyberon::action::HoldTapAction<(), usbd_human_interface_device::page::Keyboard>;

/// Macro for "shift + key".
#[macro_export]
macro_rules! sk {
    ($k:ident) => {
        Action::MultipleKeyCodes(&[usbd_human_interface_device::page::Keyboard::LeftShift, usbd_human_interface_device::page::Keyboard::$k].as_slice())
    };
}

/// Macro for "tap-hold, with super modifier".
#[macro_export]
macro_rules! s {
    ($k:ident) => {
        Action::HoldTap(&HoldTapAction {
            timeout: 200,
            tap_hold_interval: 0,
            config: keyberon::action::HoldTapConfig::Default,
            hold: Action::KeyCode(usbd_human_interface_device::page::Keyboard::LeftShift),
            tap: Action::KeyCode(usbd_human_interface_device::page::Keyboard::$k),
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
            hold: Action::KeyCode(usbd_human_interface_device::page::Keyboard::LeftControl),
            tap: Action::KeyCode(usbd_human_interface_device::page::Keyboard::$k),
        })
    };
}

/// Macro for "tap-hold, with gui modifier".
#[macro_export]
macro_rules! g {
    ($k:ident) => {
        Action::HoldTap(&keyberon::action::HoldTapAction {
            timeout: 200,
            tap_hold_interval: 0,
            config: keyberon::action::HoldTapConfig::Default,
            hold: Action::KeyCode(usbd_human_interface_device::page::Keyboard::LeftGUI),
            tap: Action::KeyCode(usbd_human_interface_device::page::Keyboard::$k),
        })
    };
}

/// Macro for "tap-hold, with alt modifier".
#[macro_export]
macro_rules! a {
    ($k:ident) => {
        Action::HoldTap(&HoldTapAction {
            timeout: 200,
            tap_hold_interval: 0,
            config: keyberon::action::HoldTapConfig::Default,
            hold: Action::KeyCode(usbd_human_interface_device::page::Keyboard::LeftAlt),
            tap: Action::KeyCode(usbd_human_interface_device::page::Keyboard::$k),
        })
    };
}

pub use sk;
pub use s;
pub use c;
pub use g;
pub use a;
