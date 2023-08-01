#pragma once

#define LWR_TAB LT(_LOWER, KC_TAB)
#define LWR_ESC LT(_LOWER, KC_ESC)

#define LW2_ESC LT(_LOWER2, KC_ESC)
#define LW2_SPC LT(_LOWER2, KC_SPC)

#define RS2_BSP LT(_RAISE2, KC_BSPC)
#define RSE_ENT LT(_RAISE, KC_ENT)

/* Home Row, outer column */
#define LCTLESC LCTL_T(KC_ESC)
#define RCTLENT RCTL_T(KC_ENT)

/* Home Row Mods, Dvorak, LH */
#define LALTT_A LALT_T(KC_A)
#define LGUIT_O LGUI_T(KC_O)
#define LCTLT_E LCTL_T(KC_E)
#define LSFTT_U LSFT_T(KC_U)

/* Home Row Mods, QWERTY, LH */
#define LGUIT_S LGUI_T(KC_S)
#define LCTLT_D LCTL_T(KC_D)
#define LSFTT_F LSFT_T(KC_F)

/* Home Row Mods, Dvorak, RH */
/* Use LHS mods instead of RHS. */
#define RSFTT_H LSFT_T(KC_H)
#define RCTLT_T LCTL_T(KC_T)
#define RGUIT_N LGUI_T(KC_N)
#define RALTT_S LALT_T(KC_S)

/* Home Row Mods, QWERTY, RH */
/* Use LHS mods instead of RHS. */
#define RSFTT_J LSFT_T(KC_J)
#define RCTLT_K LCTL_T(KC_K)
#define RGUIT_L LGUI_T(KC_L)
#define RALTTSC LALT_T(KC_SCLN)

#define ___SEG3_123___ KC_1, KC_2, KC_3
#define ___SEG3_456___ KC_4, KC_5, KC_6
#define ___SEG3_789___ KC_7, KC_8, KC_9

#define ___SEG3_S123___ KC_EXLM, KC_AT, KC_HASH
#define ___SEG3_S456___ KC_DLR,  KC_PERC, KC_CIRC
#define ___SEG3_S789___ KC_AMPR, KC_ASTR, KC_LPRN

#define ___SEG3_F123___ KC_F1, KC_F2, KC_F3
#define ___SEG3_F456___ KC_F4, KC_F5, KC_F6
#define ___SEG3_F789___ KC_F7, KC_F8, KC_F9

#define ___SEG3_SYS___ KC_PSCR, KC_SCRL, KC_PAUS

#define ___SEG4_NAV2___ KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT
#define ___SEG4_NAV_LDUR___ KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT
#define ___SEG4_NAV3___ KC_HOME, KC_PGDN, KC_PGUP, KC_END

#define ___SEG4_MOU_MV___ KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R
#define ___SEG4_MOU_WH___ KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R
#define ___SEG3_MOU_BTN___ KC_BTN1, KC_BTN2, KC_BTN3

#define ___SEG4_MED___ KC_MPRV, KC_VOLD, KC_VOLU, KC_MNXT
#define ___SEG4_MED_ALT___ KC_MNXT, KC_VOLD, KC_VOLU, KC_MPLY

#define ___SEG5_12345___ KC_1, KC_2, KC_3, KC_4, KC_5
#define ___SEG5_67890___ KC_6, KC_7, KC_8, KC_9, KC_0

#define ___SEG5_DVORAK_LHS_1___ KC_QUOT, KC_COMM, KC_DOT,  KC_P,    KC_Y
#define ___SEG5_DVORAK_LHS_2___ LALTT_A, LGUIT_O, LCTLT_E, LSFTT_U, KC_I
#define ___SEG5_DVORAK_LHS_3___ KC_SCLN, KC_Q,    KC_J,    KC_K,    KC_X

#define ___SEG5_DVORAK_RHS_1___ KC_F,    KC_G,    KC_C,    KC_R,    KC_L
#define ___SEG5_DVORAK_RHS_2___ KC_D,    RSFTT_H, RCTLT_T, RGUIT_N, RALTT_S
#define ___SEG5_DVORAK_RHS_3___ KC_B,    KC_M,    KC_W,    KC_V,    KC_Z

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

#define ___SEG5_QWERTY_LHS_1___ KC_Q,    KC_W,    KC_E,    KC_R,    KC_T
#define ___SEG5_QWERTY_LHS_2___ LALTT_A, LGUIT_S, LCTLT_D, LSFTT_F, KC_G
#define ___SEG5_QWERTY_LHS_3___ KC_Z,    KC_X,    KC_C,    KC_V,    KC_B

#define ___SEG5_QWERTY_RHS_1___ KC_Y,    KC_U,    KC_I,    KC_O,    KC_P
#define ___SEG5_QWERTY_RHS_2___ KC_H,    RSFTT_J, RCTLT_K, RGUIT_L, RALTTSC
#define ___SEG5_QWERTY_RHS_3___ KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_QUOT

#define ___SEG5_QWERTY_LHS_SIMPLE_1___ KC_Q,    KC_W,    KC_E,    KC_R,    KC_T
#define ___SEG5_QWERTY_LHS_SIMPLE_2___ KC_A,    KC_S,    KC_D,    KC_F,    KC_G
#define ___SEG5_QWERTY_LHS_SIMPLE_3___ KC_Z,    KC_X,    KC_C,    KC_V,    KC_B

#define ___SEG5_QWERTY_RHS_SIMPLE_1___ KC_Y,    KC_U,    KC_I,    KC_O,    KC_P
#define ___SEG5_QWERTY_RHS_SIMPLE_2___ KC_H,    KC_J,    KC_K,    KC_L, RALTTSC
#define ___SEG5_QWERTY_RHS_SIMPLE_3___ KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_QUOT

#define ___BASE_BOTTOM_ROW___ \
  _______, _______, _______, LWR_TAB, LW2_ESC,    KC_SPC,      RS2_BSP,    RSE_ENT, _______, _______, _______

#define ___BASE_BOTTOM_ROW_12___ \
  FN,      _______, _______, LWR_TAB, LW2_ESC,    KC_SPC, KC_SPC,     RS2_BSP,    RSE_ENT, _______, _______, _______


// macOS
#define CODE16_MACOS_DESKTOP_LEFT  LCTL(KC_LEFT)
#define CODE16_MACOS_DESKTOP_RIGHT LCTL(KC_RIGHT)

#define CODE16_MACOS_DESKTOP_LOCK LCTL(LGUI(KC_Q))

#define CODE16_MACOS_CUT   LCMD(KC_X)
#define CODE16_MACOS_COPY  LCMD(KC_C)
#define CODE16_MACOS_PASTE LCMD(KC_V)

#define CODE16_MACOS_UNDO SCMD(KC_Z)
#define CODE16_MACOS_REDO LCMD(KC_Z)

// Linux, Gnome shell
#define CODE16_LINUX_DESKTOP_LEFT  LCTL(LALT(KC_LEFT))
#define CODE16_LINUX_DESKTOP_RIGHT LCTL(LALT(KC_RIGHT))

#define CODE16_LINUX_DESKTOP_LOCK LGUI(KC_L)

// n.b. these don't always work
#define CODE16_LINUX_CUT   KC_CUT
#define CODE16_LINUX_COPY  KC_COPY
#define CODE16_LINUX_PASTE KC_PSTE

#define CODE16_LINUX_UNDO KC_UNDO
#define CODE16_LINUX_REDO KC_AGIN

// Windows 10
#define CODE16_WIN_DESKTOP_LEFT  LCTL(LGUI(KC_LEFT))
#define CODE16_WIN_DESKTOP_RIGHT LCTL(LGUI(KC_RIGHT))

#define CODE16_WIN_DESKTOP_LOCK LGUI(KC_L)

#define CODE16_WIN_CUT   C(KC_X)
#define CODE16_WIN_COPY  C(KC_C)
#define CODE16_WIN_PASTE C(KC_V)

#define CODE16_WIN_UNDO C(KC_Y)
#define CODE16_WIN_REDO C(KC_Z)

enum custom_keycodes_user {
  QUARTER = SAFE_RANGE,
  OSLINUX,
  OSMACOS,
  OSWIN,
  NEW_SAFE_RANGE,
};

enum host_os {
  _OS_LINUX,
  _OS_MACOS,
  _OS_WIN,
};
typedef enum host_os host_os_t;

extern host_os_t current_os;

#ifdef CORNER_RESET_ENABLE
extern keypos_t boot_keypositions[4];
#endif

#ifdef COMBO_ENABLE
extern combo_t key_combos[COMBO_COUNT];

enum combo_events {
  DESKTOP_GO_LEFT,
  DESKTOP_GO_RIGHT,
  LEAD,
};

extern const uint16_t PROGMEM dsk_lower_left_combo[];
extern const uint16_t PROGMEM dsk_lower_right_combo[];
extern const uint16_t PROGMEM dsk_lower_lead_combo[];

#define USER_KEY_COMBOS \
  [DESKTOP_GO_LEFT] = COMBO_ACTION(dsk_lower_left_combo),   \
  [DESKTOP_GO_RIGHT] = COMBO_ACTION(dsk_lower_right_combo), \
  [LEAD] = COMBO_ACTION(dsk_lower_lead_combo)
#endif
