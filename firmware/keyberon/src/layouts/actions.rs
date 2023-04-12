use keyberon::action::m;
use keyberon::key_code::KeyCode::*;

type Action = keyberon::action::Action<()>;

// // macOS
// #define CODE16_MACOS_DESKTOP_LEFT  LCTL(KC_LEFT)
// #define CODE16_MACOS_DESKTOP_RIGHT LCTL(KC_RIGHT)

// // Linux, Gnome shell
pub const LINUX_DESKTOP_LEFT : Action = m(&[LCtrl, LAlt, Left].as_slice());
pub const LINUX_DESKTOP_RIGHT: Action = m(&[LCtrl, LAlt, Right].as_slice());
//
// // Windows 10
// #define CODE16_WIN_DESKTOP_LEFT  LCTL(LGUI(KC_LEFT))
// #define CODE16_WIN_DESKTOP_RIGHT LCTL(LGUI(KC_RIGHT))
