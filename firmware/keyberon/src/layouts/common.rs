pub type CustomAction = ();
pub type Action =
    keyberon::action::Action<CustomAction, usbd_human_interface_device::page::Keyboard>;
pub type HoldTapAction =
    keyberon::action::HoldTapAction<CustomAction, usbd_human_interface_device::page::Keyboard>;

pub use crate::layouts::macros::{a, c, g, s, sk};
