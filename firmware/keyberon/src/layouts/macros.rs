/// Macro for "shift + key".
#[macro_export]
macro_rules! sk {
    ($k:ident) => {
        keyberon::action::Action::MultipleKeyCodes(
            &[
                usbd_human_interface_device::page::Keyboard::LeftShift,
                usbd_human_interface_device::page::Keyboard::$k,
            ]
            .as_slice(),
        )
    };
}

/// Macro for "tap-hold, with super modifier".
#[macro_export]
macro_rules! s {
    ($k:ident) => {
        keyberon::action::Action::HoldTap(&HoldTapAction {
            timeout: 200,
            tap_hold_interval: 0,
            config: keyberon::action::HoldTapConfig::Default,
            hold: keyberon::action::Action::KeyCode(
                usbd_human_interface_device::page::Keyboard::LeftShift,
            ),
            tap: keyberon::action::Action::KeyCode(usbd_human_interface_device::page::Keyboard::$k),
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
            hold: keyberon::action::Action::KeyCode(
                usbd_human_interface_device::page::Keyboard::LeftControl,
            ),
            tap: keyberon::action::Action::KeyCode(usbd_human_interface_device::page::Keyboard::$k),
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
            hold: keyberon::action::Action::KeyCode(
                usbd_human_interface_device::page::Keyboard::LeftGUI,
            ),
            tap: keyberon::action::Action::KeyCode(usbd_human_interface_device::page::Keyboard::$k),
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
            hold: keyberon::action::Action::KeyCode(
                usbd_human_interface_device::page::Keyboard::LeftAlt,
            ),
            tap: keyberon::action::Action::KeyCode(usbd_human_interface_device::page::Keyboard::$k),
        })
    };
}

pub use a;
pub use c;
pub use g;
pub use s;
pub use sk;
