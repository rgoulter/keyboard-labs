use usbd_human_interface_device::page::Keyboard::*;

use crate::layouts::common::Action;

// // macOS
// #define CODE16_MACOS_DESKTOP_LEFT  LCTL(KC_LEFT)
// #define CODE16_MACOS_DESKTOP_RIGHT LCTL(KC_RIGHT)

// // Linux, Gnome shell
pub const LINUX_DESKTOP_LEFT : Action = Action::MultipleKeyCodes(&[LeftControl, LeftAlt, LeftArrow].as_slice());
pub const LINUX_DESKTOP_RIGHT: Action = Action::MultipleKeyCodes(&[LeftControl, LeftAlt, RightArrow].as_slice());
//
// // Windows 10
// #define CODE16_WIN_DESKTOP_LEFT  LCTL(LGUI(KC_LEFT))
// #define CODE16_WIN_DESKTOP_RIGHT LCTL(LGUI(KC_RIGHT))
