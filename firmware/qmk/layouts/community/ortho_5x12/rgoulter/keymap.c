#include QMK_KEYBOARD_H
#include "action_layer.h"

#include "raw_hid.h"

#include "rgoulter.h"

extern keymap_config_t keymap_config;

// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.
enum layers {
  _DVORAK,
  _QWERTY,
  _GAMING,
  _LOWER,
  _LOWER2,
  _RAISE,
  _RAISE2,
  _CHILDPROOF,
  _ADJUST,
  _FN,
};

enum custom_keycodes {
  U_CUT = NEW_SAFE_RANGE,
  U_COPY,
  U_PASTE,
  U_UNDO,
  U_REDO,
};

#define QWERTY     DF(_QWERTY)
#define DVORAK     DF(_DVORAK)
#define GAMING     DF(_GAMING)
#define CHILDPROOF DF(_CHILDPROOF)

#define LOWER      MO(_LOWER)
#define LOWER2     MO(_LOWER2)
#define RAISE      MO(_RAISE)
#define RAISE2     MO(_RAISE2)
#define ADJUST     MO(_ADJUST)
#define FN         MO(_FN)

#define __SEG12_XXXXXXX__  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX

#define LAYOUT_wrapper(...)            LAYOUT_ortho_5x12(__VA_ARGS__)

// XXX: Let's ... move the function keys away from LOWER layer.

// XXX: not using raise2 (in QWERTY, GAMING); but, it doesn't fit here, either.

// XXX KC_APP

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

// Dvorak, with Home-Row Mods
//
// - LHS thumb keys: Tab, Esc, Spc
//     I don't use Tab frequently;
//     for code, I rely on editorconfig & auto-formatting.
// - RHS thumb keys: Bspc, Enter
//
// Pinky-outer-column
[_DVORAK] = LAYOUT_wrapper(
    _______,   ___SEG5_12345___,                              ___SEG5_67890___,                               _______,
    _______,   ___SEG5_DVORAK_LHS_1___,                       ___SEG5_DVORAK_RHS_1___,                        _______,
    _______,   ___SEG5_DVORAK_LHS_2___,                       ___SEG5_DVORAK_RHS_2___,                        _______,
    _______,   ___SEG5_DVORAK_LHS_3___,                       ___SEG5_DVORAK_RHS_3___,                        _______,
    FN,        _______, _______, LWR_TAB, LWR_ESC, LW2_SPC,    RS2_BSP, RSE_ENT, _______, _______, _______,    _______
),

// Same QWERTY as default of X-2
//
// Pinky-outer-column
[_QWERTY] = LAYOUT_wrapper(
    KC_GRV,    ___SEG5_12345___,                            ___SEG5_67890___,                            KC_BSPC,
    KC_TAB,    ___SEG5_QWERTY_LHS_SIMPLE_1___,              ___SEG5_QWERTY_RHS_SIMPLE_1___,              KC_DEL,
    KC_ESC,    ___SEG5_QWERTY_LHS_SIMPLE_2___,              ___SEG5_QWERTY_RHS_SIMPLE_2___,              KC_QUOT,
    KC_LSFT,   ___SEG5_QWERTY_LHS_SIMPLE_3___,              ___SEG5_QWERTY_RHS_SIMPLE_3___,              KC_ENT,
    FN,        KC_LCTL, KC_LALT, KC_LGUI, LOWER, KC_SPC,    KC_SPC,  RAISE,   KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT
),

// GAMING: No home row mods, but QWERTY.
//
// Bottom row half for gaming,
//  half for typing (e.g. console commands in games).
//
// Pinky-outer-column
[_GAMING] = LAYOUT_wrapper( \
    KC_GRV,    ___SEG5_12345___,                             ___SEG5_67890___,                 KC_BSPC,
    KC_TAB,    ___SEG5_QWERTY_LHS_SIMPLE_1___,               ___SEG5_QWERTY_RHS_SIMPLE_1___,   KC_DEL,
    KC_CAPS,   ___SEG5_QWERTY_LHS_SIMPLE_2___,               ___SEG5_QWERTY_RHS_SIMPLE_2___,   KC_QUOT,
    KC_LSFT,   ___SEG5_QWERTY_LHS_SIMPLE_3___,               ___SEG5_QWERTY_RHS_SIMPLE_3___,   KC_ENT,
    KC_LCTL,   KC_LGUI, KC_LALT, KC_TAB, LWR_ESC, KC_SPC,    KC_BSPC, RSE_ENT, ___SEG4_NAV_LDUR___
),

// LOWER
//
// - Number row
// - Tild ('~'), LHS, upper, outer pinky column
// - Ins, LHS, home row, outer pinky column
// - Symbols:
//   - PAIR: '_' '+'
//   - PAIR: '{' '}'
//   - PAIR (outer pinky col): '|'
//          (outer pinky col): '?'
// - Navigation keys (cursor keys, Home/etc.)
// - Function keys, across home row and lower row
//
// Pinky-outer-column
[_LOWER] = LAYOUT_wrapper( \
    __SEG12_XXXXXXX__, \
    KC_TILD,   KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC,    KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN,   KC_PIPE,
    KC_INS,    KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,      KC_F6,   KC_UNDS, KC_PLUS, KC_LCBR, KC_RCBR,   KC_QUES,
    _______,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,     KC_F12,  _______, KC_HOME, KC_PGUP, KC_PGDN,   KC_END,
    _______,   _______, _______, _______, XXXXXXX, _______,    _______, _______, KC_LEFT, KC_DOWN, KC_UP,     KC_RGHT
),

// LOWER (II)
//
// - LHO Nav
//   - inspired by Miryoku's inverted-T nav
//     - ESDF (offset from WASD)
//     - Home/End, Page Up/Down
//     - CUA cut/copy/paste
//     - CUA undo
//
// Pinky-outer-column
[_LOWER2] = LAYOUT_wrapper( \
    _______,   _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,   _______,
    _______,   KC_PGUP, KC_HOME, KC_UP,   KC_END,  KC_INS,     _______, _______, _______, _______, _______,   _______,
    _______,   KC_PGDN, KC_LEFT, KC_DOWN, KC_RGHT, KC_CAPS,    _______, _______, _______, _______, _______,   _______,
    _______,   U_UNDO,  U_CUT,   U_COPY,  U_PASTE, U_REDO,     _______, _______, _______, _______, _______,   _______,
    _______,   _______, _______, _______, _______, XXXXXXX,    _______, _______, _______, _______, _______,   _______
),

// RAISE
//
// - Number row
// - Grv ('`'), LHS, upper, outer pinky column
// - DEL, LHS, home row, outer pinky column
// - Symbols:
//   - PAIR: '-' '='
//   - PAIR: '[' ']'
//   - PAIR (outer pinky col): '\'
//          (outer pinky col): '/'
// - Media Keys
// - Clipboard keys
//
// Pinky-outer-column
[_RAISE] = LAYOUT_wrapper(
    __SEG12_XXXXXXX__,
    KC_GRV,    KC_1,    KC_2,    KC_3,    KC_4,    KC_5,       KC_6,    KC_7,    KC_8,    KC_9,    KC_0,      KC_BSLS,
    KC_DEL,    _______, _______, _______, _______, _______,    _______, KC_MINS, KC_EQL,  KC_LBRC, KC_RBRC,   KC_SLSH,
    _______,   _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,   _______,
    _______,   _______, _______, _______, _______, _______,    _______, XXXXXXX, KC_MNXT, KC_VOLD, KC_VOLU,   KC_MPLY
),

// Pinky-outer-column
[_RAISE2] = LAYOUT_wrapper(
    _______,   _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,   _______,
    _______,   _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,   _______,
    _______,   _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,   _______,
    _______,   _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,   _______,
    _______,   _______, _______, _______, _______, _______,    XXXXXXX, _______, _______, _______, _______,   _______
),

// CHILDPROOF
//
// Because mashing the keys of a mechanical keyboard can be fun,
// especially for key-reactive RGB matrix effects.
//
// Pinky-outer-column
[_CHILDPROOF] = LAYOUT_wrapper(
    __SEG12_XXXXXXX__,
    XXXXXXX,   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,   XXXXXXX,
    XXXXXXX,   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,   XXXXXXX,
    XXXXXXX,   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,   XXXXXXX,
    LOWER,     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,   RAISE
),

// ADJUST
//
// - RESET, under LHS, upper, pinky
// - CAPS, LHS, middle, outer pinky column.
// - Runtime OS selection
//     For OS-specific shortcuts, like "go desktop left"
// - PrintScr/Scroll lock/Pause
// - Default Layer Selection (QWERTY, Gaming, Dvorak, Childproof)
// - Mouse (movement, buttons, scrolling).
//
// Pinky-outer-column
[_ADJUST] = LAYOUT_wrapper(
    _______,   _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,   _______,
    _______,   QK_BOOT, _______, _______, _______, _______,    _______, ___SEG3_SYS___,            _______,   _______,
    KC_CAPS,   DM_REC2, DM_REC1, DM_PLY2, DM_PLY1, DM_RSTP,    _______, QWERTY,  GAMING,  DVORAK,  CHILDPROOF,  _______,
    _______,   _______, OSWIN,   OSMACOS, OSLINUX, _______,    _______, _______, KC_BTN1, KC_BTN2, KC_WH_D,   KC_WH_U,
    _______,   _______, _______, _______, XXXXXXX, _______,    _______, XXXXXXX, KC_MS_L, KC_MS_D, KC_MS_U,   KC_MS_R
),

// FN
//
// - Numpad, actual numpad keys, LHO accessible.
// - RGB control
//
// Same as default layer
[_FN] = LAYOUT(
    _______,   _______, _______, _______, _______, _______,    _______, _______, _______, RGB_SPD, RGB_SPI,   _______,
    KC_NUM,    KC_P7,   KC_P8,   KC_P9,   _______, _______,    _______, _______, _______, RGB_VAD, RGB_VAI,   _______,
    _______,   KC_P4,   KC_P5,   KC_P6,   _______, _______,    _______, _______, _______, RGB_SAD, RGB_SAI,   _______,
    _______,   KC_P1,   KC_P2,   KC_P3,   _______, _______,    _______, _______, RGB_TOG, RGB_HUD, RGB_HUI,   RGB_MOD,
    XXXXXXX,   _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,   _______
)

};

layer_state_t layer_state_set_user(layer_state_t state) {
  return update_tri_layer_state(state, _LOWER, _RAISE, _ADJUST);
}

bool process_record_keymap(uint16_t keycode, keyrecord_t *record) {
  bool pressed = record->event.pressed;
  switch (keycode) {
  case U_CUT:
    if (pressed) {
      switch(current_os) {
        case _OS_LINUX:
          tap_code16(CODE16_LINUX_CUT);
          break;
        case _OS_MACOS:
          tap_code16(CODE16_MACOS_CUT);
          break;
        case _OS_WIN:
          tap_code16(CODE16_WIN_CUT);
          break;
      }
    }
    return false;
  case U_COPY:
    if (pressed) {
      switch(current_os) {
        case _OS_LINUX:
          tap_code16(CODE16_LINUX_COPY);
          break;
        case _OS_MACOS:
          tap_code16(CODE16_MACOS_COPY);
          break;
        case _OS_WIN:
          tap_code16(CODE16_WIN_COPY);
          break;
      }
    }
    return false;
  case U_PASTE:
    if (pressed) {
      switch(current_os) {
        case _OS_LINUX:
          tap_code16(CODE16_LINUX_PASTE);
          break;
        case _OS_MACOS:
          tap_code16(CODE16_MACOS_PASTE);
          break;
        case _OS_WIN:
          tap_code16(CODE16_WIN_PASTE);
          break;
      }
    }
    return false;
  case U_UNDO:
    if (pressed) {
      switch(current_os) {
        case _OS_LINUX:
          tap_code16(CODE16_LINUX_UNDO);
          break;
        case _OS_MACOS:
          tap_code16(CODE16_MACOS_UNDO);
          break;
        case _OS_WIN:
          tap_code16(CODE16_WIN_UNDO);
          break;
      }
    }
    return false;
  case U_REDO:
    if (pressed) {
      switch(current_os) {
        case _OS_LINUX:
          tap_code16(CODE16_LINUX_REDO);
          break;
        case _OS_MACOS:
          tap_code16(CODE16_MACOS_REDO);
          break;
        case _OS_WIN:
          tap_code16(CODE16_WIN_REDO);
          break;
      }
    }
    return false;

  }
  return true;
}


// RAW_EPSIZE is 32
void raw_hid_receive(uint8_t *data, uint8_t length) {
    raw_hid_send(data, length);
}

void keyboard_post_init_user(void) {
#ifdef RGBLIGHT_ENABLE
  rgblight_mode_noeeprom(RGBLIGHT_MODE_RAINBOW_SWIRL + 4);
#endif
#ifdef RGB_MATRIX_ENABLE
  rgb_matrix_mode_noeeprom(RGB_MATRIX_CYCLE_PINWHEEL);
#endif
}

bool get_tapping_force_hold(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LW2_SPC:
            // tap then hold: repeat the tap
            return false;
        case RS2_BSP:
            // tap then hold: repeat the tap
            return false;
        default:
            // use the hold function
            return true;
    }
}

#ifdef RGB_MATRIX_ENABLE
bool rgb_matrix_indicators_advanced_user(uint8_t led_min, uint8_t led_max) {
    // Dim the 4 indicator LEDs in the middle of the board.
    HSV hsv = rgb_matrix_get_hsv();
    hsv.v /= 4;
    RGB rgb = hsv_to_rgb(hsv);
    for (uint8_t i = led_min; i <= led_max; i++) {
        if (HAS_FLAGS(g_led_config.flags[i], LED_FLAG_INDICATOR)) {
            rgb_matrix_set_color(i, rgb.r, rgb.g, rgb.b);
        }
    }
    return false;
}
#endif
