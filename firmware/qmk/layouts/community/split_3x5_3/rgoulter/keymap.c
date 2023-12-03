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

#ifdef HAPTIC_ENABLE
#include "solenoid.h"
#endif

#include "rgoulter.h"

// Defines names for use in layer keycodes and the keymap
enum layers {
    _DVORAK,
    _QWERTY,
    _CHECK,
    _CHILDPROOF,
    _NAVR,
    _MOUR,
    _MEDR,
    _NSL,
    _NSSL,
    _FUNL,
    _GAME_ALT,
    _GAME_DF,
};

#define CHECK     DF(_CHECK)
#define DVORAK     DF(_DVORAK)
#define QWERTY     DF(_QWERTY)
#define BASE       DF(_DVORAK)
#define GAME_AL     DF(_GAME_ALT)
#define GAME_DF     DF(_GAME_DF)
#define CHILDPROOF     DF(_CHILDPROOF)
#define SPC_NAVR  LT(_NAVR, KC_SPC)
#define TAB_MOUR  LT(_MOUR, KC_TAB)
#define ESC_MEDR  LT(_MEDR, KC_ESC)
#define BKSP_NSL   LT(_NSL, KC_BSPC)
#define ENT_NSSL  LT(_NSSL, KC_ENT)
#define DEL_FUNL  LT(_FUNL, KC_DEL)

#define LAYOUT_wrapper(...) LAYOUT_split_3x5_3(__VA_ARGS__)
#define LAYOUT_split_3x5_3_wrapper(...) LAYOUT_split_3x5_3(__VA_ARGS__)

#ifdef RHS_THUMB_MEDIAL
// Medial = closer to body's middle.
//
// This thumb row is the same as Miryoku's
//
// e.g. on Pico42 (or when using 3 thumbkeys on ortho5x12),
// I find it more comfortable to have the 'third key' for RHS be more medial,
// so that the main two RHS thumb keys are below 'nm'.
#  define THUMB_ROW TAB_MOUR, ESC_MEDR, SPC_NAVR,    ENT_NSSL, BKSP_NSL, DEL_FUNL
#else
// e.g. on X-1, the 'third key' for RHS is more lateral than the others
#  define THUMB_ROW TAB_MOUR, ESC_MEDR, SPC_NAVR,    BKSP_NSL, ENT_NSSL, DEL_FUNL
#endif


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
// Different from Miryoku: LHS thumb keys: {Tab, Esc, Spc} instead of {Esc, Spc, Tab}
// Different from Miryoku: RHS thumb keys: {Tab, Esc, Spc} instead of {Esc, Spc, Tab}
// Different from Miryoku: Dvorak: retain semicolon, instead of using slash.
[_DVORAK] = LAYOUT_wrapper( \
  ___SEG5_DVORAK_LHS_1___,                           ___SEG5_DVORAK_RHS_1___,
  ___SEG5_DVORAK_LHS_2___,                           ___SEG5_DVORAK_RHS_2___,
  ___SEG5_DVORAK_LHS_3___,                           ___SEG5_DVORAK_RHS_3___,
                    THUMB_ROW
),

// Different from Miryoku: LHS thumb keys: {Tab, Esc, Spc} instead of {Esc, Spc, Tab}
// Different from Miryoku: RHS thumb keys: {Bksp, Ent, Del} instead of {Ent, Bspc, Del}
[_QWERTY] = LAYOUT_wrapper( \
  ___SEG5_QWERTY_LHS_1___,                           ___SEG5_QWERTY_RHS_1___,
  ___SEG5_QWERTY_LHS_2___,                           ___SEG5_QWERTY_RHS_2___,
  ___SEG5_QWERTY_LHS_3___,                           ___SEG5_QWERTY_RHS_3___,
                    THUMB_ROW
),

[_CHECK] = LAYOUT_wrapper( \
  ___SEG5_DVORAK_LHS_1___,                           ___SEG5_DVORAK_RHS_1___,
  ___SEG5_DVORAK_LHS_2___,                           ___SEG5_DVORAK_RHS_2___,
  ___SEG5_DVORAK_LHS_3___,                           ___SEG5_DVORAK_RHS_3___,
                    KC_1, KC_2, KC_3, KC_4, KC_5, KC_6
),

// XXX: Different from Miryoku: Nav, RHS, upper: TBI the convenience cut/copy/paste and undo/redo
[_NAVR] = LAYOUT_wrapper( \
  _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,
  _______, _______, _______, _______, _______,    ___SEG4_NAV2___, CW_TOGG,
  _______, OSWIN,   OSMACOS, OSLINUX, _______,    ___SEG4_NAV3___, KC_INS,
                    _______, _______, _______,    _______, _______, _______
),

[_MOUR] = LAYOUT_wrapper( \
  _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,
  _______, _______, _______, _______, _______,    ___SEG4_MOU_MV___, _______,
  _______, _______, _______, _______, _______,    ___SEG4_MOU_WH___, _______,
                    _______, _______, _______,    ___SEG3_MOU_BTN___
),

// Different from Miryoku: Media layer, RHS, lower: used to swap base layers
// Different from Miryoku: Media layer, RHS: RGB doesn't follow Nav swap
// Different from Miryoku: Media layer, RHS, non-nav column: no external power, no Bluetooth
[_MEDR] = LAYOUT_wrapper( \
  _______, _______, _______, HF_RST,  _______,    RGB_TOG, RGB_MOD, RGB_HUI, RGB_SAI, RGB_VAI,
  HF_BUZZ, HF_DWLU, HF_DWLD, HF_TOGG, HF_FDBK,    ___SEG4_MED___, _______,
  _______, _______, _______, DB_TOGG, _______,    QWERTY,  DVORAK,  GAME_DF, GAME_AL, QK_BOOT,
                    _______, _______, _______,    KC_MPLY, KC_MSTP, KC_MUTE
),

// Different from Miryoku: Number layer, LHS: GRV in middle & slash (rather than semicolon)
[_NSL] = LAYOUT_wrapper( \
  KC_LBRC, ___SEG3_789___, KC_RBRC,        _______, _______, _______, _______, _______,
  KC_GRV,  ___SEG3_456___, KC_EQL,         _______, _______, _______, _______, _______,
  KC_SLSH, ___SEG3_123___, KC_BSLS,        _______, _______, _______, _______, _______,
                 KC_DOT, KC_0, KC_MINS,    _______, _______, _______
),

// Different from Miryoku: Number layer, LHS: TILD in middle & slash (rather than colon)
[_NSSL] = LAYOUT_wrapper( \
  KC_LCBR, ___SEG3_S789___, KC_RCBR,              _______, _______, _______, _______, _______,
  KC_TILD, ___SEG3_S456___, KC_PLUS,              _______, _______, _______, _______, _______,
  KC_QUES, ___SEG3_S123___, KC_PIPE,              _______, _______, _______, _______, _______,
                    KC_LPRN, KC_RPRN, KC_UNDS,    _______, _______, _______
),

[_FUNL] = LAYOUT_wrapper( \
  KC_F12, ___SEG3_F789___,   KC_PSCR,           _______, _______, _______, _______, _______,
  KC_F11, ___SEG3_F456___,   KC_SCRL,           _______, _______, _______, _______, _______,
  KC_F10, ___SEG3_F123___,   KC_PAUS,           _______, _______, _______, _______, _______,
                  _______, _______, _______,    _______, _______, _______
),

#include <game-tomb_raider.inc>

};

void keyboard_post_init_user(void) {
#ifdef RGB_MATRIX_ENABLE
    /* rgb_matrix_mode_noeeprom(RGB_MATRIX_MULTISPLASH); */
    rgb_matrix_mode_noeeprom(RGB_MATRIX_CYCLE_PINWHEEL);
#endif
#ifdef HAPTIC_ENABLE
    solenoid_set_dwell(200);
#endif
}

#ifdef ENCODER_ENABLE
bool encoder_update_user(uint8_t index, bool clockwise) {
    if (clockwise) {
        tap_code(KC_DOWN);
    } else {
        tap_code(KC_UP);
    }
    return false;
}
#endif

#ifdef OLED_ENABLE
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

bool oled_task_user(void) {
  test_characters();

  return false;
}
#endif
