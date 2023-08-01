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
  _LOWER,
  _LOWER2,
  _RAISE,
  _RAISE2,
  _CHILDPROOF,
  _CHECK,
  _NUMPAD,
  _ADJUST,
};

#define QWERTY     DF(_QWERTY)
#define DVORAK     DF(_DVORAK)
#define CHILDPROOF DF(_CHILDPROOF)
#define CHECK DF(_CHECK)
#define LOWER   MO(_LOWER)
#define LOWER2   MO(_LOWER2)
#define RAISE   MO(_RAISE)
#define RAISE2   MO(_RAISE2)
#define NUMPAD  MO(_NUMPAD)
#define ADJUST  MO(_ADJUST)

#undef ___BASE_BOTTOM_ROW___
#define ___BASE_BOTTOM_ROW___ \
  NUMPAD, _______, _______, LWR_TAB, LW2_ESC,    KC_SPC,      RS2_BSP,    RSE_ENT, _______, _______, _______

#define LAYOUT_wrapper(...)            LAYOUT_planck_mit(__VA_ARGS__)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

// XXX: aim for one-handed cursor keys?

[_DVORAK] = LAYOUT_wrapper( \
  ___SEG5_DVORAK_LHS_1___, KC_TAB,     KC_BSPC, ___SEG5_DVORAK_RHS_1___,    \
  ___SEG5_DVORAK_LHS_2___, LCTLESC,    RCTLENT, ___SEG5_DVORAK_RHS_2___, \
  ___SEG5_DVORAK_LHS_3___, _______,    _______, ___SEG5_DVORAK_RHS_3___,      \
                                           ___BASE_BOTTOM_ROW___ \
),

[_QWERTY] = LAYOUT_wrapper( \
  ___SEG5_QWERTY_LHS_1___, KC_TAB,     KC_BSPC, ___SEG5_QWERTY_RHS_1___,    \
  ___SEG5_QWERTY_LHS_2___, LCTLESC,    RCTLENT, ___SEG5_QWERTY_RHS_2___, \
  ___SEG5_QWERTY_LHS_3___, _______,    _______, ___SEG5_QWERTY_RHS_3___,      \
                                           ___BASE_BOTTOM_ROW___ \
),

/*
 * QWERTY mod: Swap the `'` and `/`.
 *
 * Within the 3x10 grid:
 *   Dvorak's symbol keys: ',. and ;
 *   QWERTY's symbol keys: ,./ and ;
 *
 * thus, Dvorak *needs* `/` on other layers,
 *       QWERTY *needs* `'` on other layers.
 *
 * Instead, it's easier to swap `'` and `/` for QWERTY,
 *  so that it also needs `/` on other layers.
 */

[_LOWER] = LAYOUT_wrapper( \
  KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC, KC_TILD, KC_PIPE, KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, \
  KC_TILD, _______, _______, _______, _______, KC_INS,  KC_QUES, KC_INS,  KC_UNDS, KC_PLUS, KC_LCBR, KC_RCBR, \
  KC_QUES, KC_CUT,  KC_COPY, KC_PSTE, KC_PIPE, _______, _______, _______, _______, _______, KC_QUES, KC_PIPE, \
  _______, _______, _______, XXXXXXX, _______,     _______,      _______, _______, _______, _______, _______ \
),

[_LOWER2] = LAYOUT_wrapper( \
  KC_F12,  KC_F7,   KC_F8,   KC_F9,   KC_PSCR, _______, _______, _______, _______, _______, _______, _______, \
  KC_F11,  KC_F4,   KC_F5,   KC_F6,   KC_SCRL, _______, _______, ___SEG4_NAV_LDUR___, _______, \
  KC_F10,  KC_F1,   KC_F2,   KC_F3,   KC_PAUS, _______, _______, ___SEG4_NAV3___,     _______, \
  _______, _______, _______, _______, XXXXXXX,     _______,      _______, _______, _______, _______, _______ \
),

/*
 * not sure where slash/backslash should be
 * inner columns are terrible for frequent keys,
 * the inner-index column is annoying for
 * the same side as the layer.
 */
/*
 * n.b. HID Cut/Copy/Paste aren't widely supported.
 *
 * e.g. Works in Firefox, Slack, VSCode, Alacritty.
 * e.g. Doesn't work out of the box with Emacs (unbound),
 *       Kitty, or even some programs like Kicad or OpenScad.
 */
[_RAISE] = LAYOUT_planck_mit( \
  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_GRV,  KC_BSLS, KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    \
  KC_GRV,  _______, _______, _______, _______, KC_DEL,  KC_SLSH, KC_DEL,  KC_MINS, KC_EQL,  KC_LBRC, KC_RBRC, \
  KC_SLSH, KC_CUT,  KC_COPY, KC_PSTE, KC_BSLS, _______, _______, _______, _______, _______, KC_SLSH, KC_BSLS, \
  _______, _______, _______, _______, _______,    _______,       _______, XXXXXXX, _______, _______, _______ \
),

[_RAISE2] = LAYOUT_wrapper( \
  _______, _______, _______, _______, _______, _______, _______, _______, KC_BTN1, KC_BTN2, KC_BTN3, _______, \
  _______, _______, _______, _______, _______, _______, _______, ___SEG4_MOU_MV___,                  _______, \
  _______, _______, _______, _______, _______, _______, _______, ___SEG4_MOU_WH___,                  _______, \
  _______, _______, _______, _______, _______,     _______,      XXXXXXX, _______, _______, _______, _______ \
),

[_CHILDPROOF] = LAYOUT_planck_mit( \
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, \
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, \
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, \
  LOWER,   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX,      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, RAISE \
),

// CHECK
//
// Because mashing the keys of a mechanical keyboard can be fun,
// especially for key-reactive RGB matrix effects.
//
// Pinky-outer-column
[_CHECK] = LAYOUT_wrapper(
    KC_1, ___SEG5_QWERTY_LHS_SIMPLE_1___,              ___SEG5_QWERTY_RHS_SIMPLE_1___, KC_X,
    KC_2, ___SEG5_QWERTY_LHS_SIMPLE_2___,              ___SEG5_QWERTY_RHS_SIMPLE_2___, KC_Y,
    KC_3, ___SEG5_QWERTY_LHS_SIMPLE_3___,              ___SEG5_QWERTY_RHS_SIMPLE_3___, KC_Z,
    KC_4, KC_1, KC_2, KC_3, KC_4,            KC_5,     KC_7, KC_8, KC_9, KC_0, KC_W
),

[_NUMPAD] = LAYOUT_planck_mit( \
  _______, KC_7,    KC_8,    KC_9,   _______, _______, _______, _______, _______,    _______,    _______,    _______, \
  _______, KC_4,    KC_5,    KC_6,   _______, _______, _______, _______, _______,    _______,    _______,    _______, \
  _______, KC_1,    KC_2,    KC_3,   _______, _______, _______, _______, _______,    _______,    _______,    _______, \
  XXXXXXX, KC_0,    KC_0,    KC_DOT, _______,     _______,      _______, _______,    _______,    _______,  _______  \
),

[_ADJUST] =  LAYOUT_wrapper( \
  QK_BOOT, RGB_TOG, RGB_MOD, RGB_HUI, RGB_HUD, RGB_SAI, RGB_SAD, RGB_VAI, RGB_VAD, RGB_SPI, RGB_SPD, _______,
  KC_CAPS, _______, _______, _______, _______, _______, _______, QWERTY,  XXXXXXX, DVORAK,  CHILDPROOF, CHECK, \
  _______, _______, OSWIN,   OSMACOS, OSLINUX, _______, _______, ___SEG4_MED___, KC_MPLY, \
  _______, _______, _______, XXXXXXX, _______,     _______,      _______, XXXXXXX, _______, _______, _______ \
)

};

layer_state_t layer_state_set_user(layer_state_t state) {
  return update_tri_layer_state(state, _LOWER, _RAISE, _ADJUST);
}

// RAW_EPSIZE is 32
void raw_hid_receive(uint8_t *data, uint8_t length) {
    raw_hid_send(data, length);
}

void matrix_init_kb(void) {
#ifdef PINKIELESS_LAYOUT
#ifdef RGB_MATRIX_ENABLE
    // Pinky outer column: change the flags
    g_led_config.flags[0] = 4;
    g_led_config.flags[11] = 4;
    g_led_config.flags[12] = 4;
    g_led_config.flags[23] = 4;
    g_led_config.flags[24] = 4;
    g_led_config.flags[35] = 4;

    g_led_config.flags[5] = 1;
    g_led_config.flags[6] = 1;
    g_led_config.flags[17] = 1;
    g_led_config.flags[18] = 1;
    g_led_config.flags[29] = 1;
    g_led_config.flags[30] = 1;
#endif
#endif
}

