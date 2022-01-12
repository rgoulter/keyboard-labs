/* Copyright 2021 Richard Goulter
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include QMK_KEYBOARD_H

#include "print.h"

#include "rgoulter.h"

// Defines names for use in layer keycodes and the keymap
enum layers {
  _DVORAK,
  _QWERTY,
  _CHILDPROOF,
  _NAVR,
  _MOUR,
  _MEDR,
  _NSL,
  _NSSL,
  _FUNL,
};

#define DVORAK     DF(_DVORAK)
#define QWERTY     DF(_QWERTY)
#define CHILDPROOF     DF(_CHILDPROOF)
#define SPC_NAVR  LT(_NAVR, KC_SPC)
#define TAB_MOUR  LT(_MOUR, KC_TAB)
#define ESC_MEDR  LT(_MEDR, KC_ESC)
#define BKSP_NSL   LT(_NSL, KC_BSPC)
#define ENT_NSSL  LT(_NSSL, KC_ENT)
#define DEL_FUNL  LT(_FUNL, KC_DEL)

#define LAYOUT_wrapper(...) LAYOUT(__VA_ARGS__)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
[_DVORAK] = LAYOUT_wrapper( \
  ___SEG5_DVORAK_LHS_1___,                           ___SEG5_DVORAK_RHS_1___,
  ___SEG5_DVORAK_LHS_2___,                           ___SEG5_DVORAK_RHS_2___,
  ___SEG5_DVORAK_LHS_3___,                           ___SEG5_DVORAK_RHS_3___,
                    TAB_MOUR, ESC_MEDR, SPC_NAVR,    BKSP_NSL, ENT_NSSL, DEL_FUNL
),

[_QWERTY] = LAYOUT_wrapper( \
  ___SEG5_QWERTY_LHS_1___,                           ___SEG5_QWERTY_RHS_1___,
  ___SEG5_QWERTY_LHS_2___,                           ___SEG5_QWERTY_RHS_2___,
  ___SEG5_QWERTY_LHS_3___,                           ___SEG5_QWERTY_RHS_3___,
                     TAB_MOUR, ESC_MEDR, SPC_NAVR,    BKSP_NSL, ENT_NSSL, DEL_FUNL
),

[_NAVR] = LAYOUT_wrapper( \
  _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,
  _______, _______, _______, _______, _______,    ___SEG4_NAV2___, _______,
  _______, _______, _______, _______, _______,    ___SEG4_NAV3___, KC_INS,
                    _______, _______, _______,    _______, _______, _______
),

[_MOUR] = LAYOUT_wrapper( \
  _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,
  _______, _______, _______, _______, _______,    ___SEG4_MOU_MV___, _______,
  _______, _______, _______, _______, _______,    ___SEG4_MOU_WH___, _______,
                    _______, _______, _______,    ___SEG3_MOU_BTN___
),

[_MEDR] = LAYOUT_wrapper( \
  _______, _______, _______, _______, _______,    RGB_TOG, RGB_MOD, RGB_HUI, RGB_SAI, RGB_VAI,
  _______, _______, _______, _______, _______,    ___SEG4_MED___, _______,
  _______, _______, _______, _______, _______,    QWERTY,  DVORAK,  _______, _______, RESET,
                    _______, _______, _______,    KC_MPLY, KC_MSTP, KC_MUTE
),

[_NSL] = LAYOUT_wrapper( \
  KC_LBRC, ___SEG3_789___, KC_RBRC,        _______, _______, _______, _______, _______,
  KC_GRV,  ___SEG3_456___, KC_EQL,         _______, _______, _______, _______, _______,
  KC_SLSH, ___SEG3_123___, KC_BSLS,        _______, _______, _______, _______, _______,
                 KC_DOT, KC_0, KC_MINS,    _______, _______, _______
),

[_NSSL] = LAYOUT_wrapper( \
  KC_LCBR, ___SEG3_S789___, KC_RCBR,              _______, _______, _______, _______, _______,
  KC_TILD, ___SEG3_S456___, KC_PLUS,              _______, _______, _______, _______, _______,
  KC_QUES, ___SEG3_S123___, KC_PIPE,              _______, _______, _______, _______, _______,
                    KC_LPRN, KC_RPRN, KC_UNDS,    _______, _______, _______
),

[_FUNL] = LAYOUT_wrapper( \
  KC_F12, ___SEG3_F789___,   _______,           _______, _______, _______, _______, _______,
  KC_F11, ___SEG3_F456___,   _______,           _______, _______, _______, _______, _______,
  KC_F10, ___SEG3_F123___,   _______,           _______, _______, _______, _______, _______,
                  _______, _______, _______,    _______, _______, _______
),

};

#ifdef COMBO_ENABLE
enum combo_events {
  DESKTOP_GO_LEFT,
  DESKTOP_GO_RIGHT,
  LEAD,
};

// can't be keys which have tap-hold
const uint16_t PROGMEM dsk_lower_left_combo[] = {KC_J, KC_K, COMBO_END};
// const uint16_t PROGMEM dsk_lower_left_combo[] = {LCTLT_E, LSFTT_U, COMBO_END};
const uint16_t PROGMEM dsk_lower_right_combo[] = {KC_M, KC_W, COMBO_END};

combo_t key_combos[COMBO_COUNT] = {
  [DESKTOP_GO_LEFT] = COMBO_ACTION(dsk_lower_left_combo),
  [DESKTOP_GO_RIGHT] = COMBO_ACTION(dsk_lower_right_combo),
};

void process_combo_event(uint16_t combo_index, bool pressed) {
  switch(combo_index) {
    case DESKTOP_GO_LEFT:
      if (pressed) {
        tap_code16(CODE16_LINUX_DESKTOP_LEFT);
      }
      break;
    case DESKTOP_GO_RIGHT:
      if (pressed) {
        tap_code16(CODE16_LINUX_DESKTOP_RIGHT);
      }
      break;
  }
}
#endif

void keyboard_post_init_user(void) {
#ifdef RGB_MATRIX_ENABLE
  // rgb_matrix_mode_noeeprom(RGB_MATRIX_MULTISPLASH);
  rgb_matrix_mode_noeeprom(RGB_MATRIX_CYCLE_PINWHEEL);
#endif
}

bool encoder_update_user(uint8_t index, bool clockwise) {
        if (clockwise) {
            tap_code(KC_DOWN);
        } else {
            tap_code(KC_UP);
        }
        return false;
}

#ifdef OLED_DRIVER_ENABLE
oled_rotation_t oled_init_user(oled_rotation_t rotation) {
    oled_scroll_set_area(0, 0);
    oled_scroll_set_speed(0);

    // For simplicity,
    // this only allows the left-hand board to be master.
    // If the right-hand board is used as master,
    // the OLEDs are rendered "upside down".
    if (is_keyboard_master()) {
        return OLED_ROTATION_180;  // flips the display 180 degrees if offhand
    }

    return rotation;
}

// Use all 94 visible ASCII characters for testing.
static void test_logo(void) {
    uint8_t lines = oled_max_lines();
    if (lines > 3) {
        lines = 3;
    }
    uint8_t chars = oled_max_chars();
    if (chars > 21) {
        chars = 21;
    }
    for (uint8_t row = 0; row < lines; ++row) {
        oled_set_cursor(0, row);
        for (uint8_t col = 0; col < chars; ++col) {
            oled_write_char(0x80 + 0x20 * row + col, false);
        }
    }
}

/*
#define TEST_CHAR_COUNT ('~' - '!' + 1)

static char get_test_char(uint8_t char_index) { return char_index + '!'; }

// Fill the whole screen with distinct characters (if the display is large enough to show more than 94 characters
// at once, the sequence is repeated the second time with inverted characters).
static void test_characters(void) {
    uint8_t cols       = oled_max_chars();
    uint8_t rows       = oled_max_lines();
    bool    invert     = false;
    uint8_t char_index = 0;
    for (uint8_t row = 0; row < rows; ++row) {
        for (uint8_t col = 0; col < cols; ++col) {
            oled_write_char(get_test_char(char_index), invert);
            if (++char_index >= TEST_CHAR_COUNT) {
                char_index = 0;
                invert     = !invert;
            }
        }
    }
}

// */
void oled_task_user(void) {
    // Host Keyboard Layer Status
  test_logo();
  // test_characters();
  /*
    oled_clear();
    oled_write(("Layer: "), false);

    switch (get_highest_layer(layer_state)) {
    case _DVORAK:
            oled_write_ln(("Dvorak"), false);
            break;
    case _QWERTY:
            oled_write_ln(("QWERTY"), false);
            break;
    case _CHILDPROOF:
            oled_write_ln(("CHILDPROOF"), false);
            break;
    case _NAVR:
            oled_write_ln(("NAVR"), false);
            break;
    case _MOUR:
            oled_write_ln(("MOUR"), false);
            break;
    case _MEDR:
            oled_write_ln(("MEDR"), false);
            break;
    case _NSL:
            oled_write_ln(("NSL"), false);
            break;
    case _NSSL:
            oled_write_ln(("NSSL"), false);
            break;
    case _FUNL:
            oled_write_ln(("FUNL"), false);
            break;
        default:
            // Or use the write_ln shortcut over adding '\n' to the end of your string
            oled_write_ln(("Undefined"), false);
    }

  */
}
#endif
