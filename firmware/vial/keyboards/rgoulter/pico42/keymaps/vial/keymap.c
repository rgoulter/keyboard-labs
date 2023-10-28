// Copyright 2023 QMK
// SPDX-License-Identifier: GPL-2.0-or-later

#include QMK_KEYBOARD_H

enum layers {
    _QWERTY,
    _NAVR,
    _MOUR,
    _MEDR,
    _NSL,
    _NSSL,
    _FUNL,
};

#define QWERTY    DF(_QWERTY)
#define SPC_NAVR  LT(_NAVR, KC_SPC)
#define TAB_MOUR  LT(_MOUR, KC_TAB)
#define ESC_MEDR  LT(_MEDR, KC_ESC)
#define BKSP_NSL  LT(_NSL, KC_BSPC)
#define ENT_NSSL  LT(_NSSL, KC_ENT)
#define DEL_FUNL  LT(_FUNL, KC_DEL)

#define LAYOUT_wrapper(...) LAYOUT_split_3x5_3(__VA_ARGS__)
#define LAYOUT_split_3x5_3_wrapper(...) LAYOUT_split_3x5_3(__VA_ARGS__)

/* Home Row Mods, QWERTY, LH */
#define LALTT_A LALT_T(KC_A)
#define LGUIT_S LGUI_T(KC_S)
#define LCTLT_D LCTL_T(KC_D)
#define LSFTT_F LSFT_T(KC_F)

/* Home Row Mods, QWERTY, RH */
/* Use LHS mods instead of RHS. */
#define RSFTT_J LSFT_T(KC_J)
#define RCTLT_K LCTL_T(KC_K)
#define RGUIT_L LGUI_T(KC_L)
#define RALTTSC LALT_T(KC_SCLN)

// Different from Miryoku: LHS thumb keys: {Tab, Esc, Spc} instead of {Esc, Spc, Tab}
#define THUMB_ROW TAB_MOUR, ESC_MEDR, SPC_NAVR,     ENT_NSSL, BKSP_NSL, DEL_FUNL

/*
 * QWERTY mod: Swap the `'` and `/`.
 * (so that symbol layer has both `/` and `\`).
 */
#define ___SEG5_QWERTY_LHS_1___ KC_Q,    KC_W,    KC_E,    KC_R,    KC_T
#define ___SEG5_QWERTY_LHS_2___ LALTT_A, LGUIT_S, LCTLT_D, LSFTT_F, KC_G
#define ___SEG5_QWERTY_LHS_3___ KC_Z,    KC_X,    KC_C,    KC_V,    KC_B

#define ___SEG5_QWERTY_RHS_1___ KC_Y,    KC_U,    KC_I,    KC_O,    KC_P
#define ___SEG5_QWERTY_RHS_2___ KC_H,    RSFTT_J, RCTLT_K, RGUIT_L, RALTTSC
#define ___SEG5_QWERTY_RHS_3___ KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_QUOT

#define ___SEG3_123___ KC_1, KC_2, KC_3
#define ___SEG3_456___ KC_4, KC_5, KC_6
#define ___SEG3_789___ KC_7, KC_8, KC_9

#define ___SEG3_S123___ KC_EXLM, KC_AT, KC_HASH
#define ___SEG3_S456___ KC_DLR,  KC_PERC, KC_CIRC
#define ___SEG3_S789___ KC_AMPR, KC_ASTR, KC_LPRN

#define ___SEG3_F123___ KC_F1, KC_F2, KC_F3
#define ___SEG3_F456___ KC_F4, KC_F5, KC_F6
#define ___SEG3_F789___ KC_F7, KC_F8, KC_F9

#define ___SEG4_NAV2___ KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT
#define ___SEG4_NAV_LDUR___ KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT
#define ___SEG4_NAV3___ KC_HOME, KC_PGDN, KC_PGUP, KC_END

#define ___SEG4_MOU_MV___ KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R
#define ___SEG4_MOU_WH___ KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R
#define ___SEG3_MOU_BTN___ KC_BTN1, KC_BTN2, KC_BTN3

#define ___SEG4_MED___ KC_MPRV, KC_VOLD, KC_VOLU, KC_MNXT

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

[_QWERTY] = LAYOUT_wrapper( \
  ___SEG5_QWERTY_LHS_1___,                           ___SEG5_QWERTY_RHS_1___,
  ___SEG5_QWERTY_LHS_2___,                           ___SEG5_QWERTY_RHS_2___,
  ___SEG5_QWERTY_LHS_3___,                           ___SEG5_QWERTY_RHS_3___,
                    THUMB_ROW
),

// TBI: Different from Miryoku: Nav, RHS, upper: TBI: the convenience cut/copy/paste and undo/redo
[_NAVR] = LAYOUT_wrapper( \
  _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,
  _______, _______, _______, _______, _______,    ___SEG4_NAV2___, CW_TOGG,
  _______, _______, _______, _______, _______,    ___SEG4_NAV3___, KC_INS,
                    _______, _______, _______,    _______, _______, _______
),

[_MOUR] = LAYOUT_wrapper( \
  _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,
  _______, _______, _______, _______, _______,    ___SEG4_MOU_MV___, _______,
  _______, _______, _______, _______, _______,    ___SEG4_MOU_WH___, _______,
                    _______, _______, _______,    ___SEG3_MOU_BTN___
),

// Different from Miryoku: Media layer, RHS, lower: used to swap base layers / bootloader.
// Different from Miryoku: Media layer, RHS, non-nav column: no external power, no Bluetooth
[_MEDR] = LAYOUT_wrapper( \
  _______, _______, _______, _______, _______,    _______, _______, _______, _______, _______,
  _______, _______, _______, _______, _______,    ___SEG4_MED___, _______,
  _______, _______, _______, _______, _______,    QWERTY,  _______, _______, _______, QK_BOOT,
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


};
