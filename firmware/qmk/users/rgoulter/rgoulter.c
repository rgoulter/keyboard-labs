#include "quantum.h"

#include "rgoulter.h"

char quarter_count = 0;
host_os_t current_os = _OS_LINUX;

#ifdef CORNER_RESET_ENABLE
__attribute__ ((weak))
keypos_t boot_keypositions[4] = {
  { .col = 0, .row = 0 },
  { .col = 0, .row = MATRIX_ROWS - 1 },
  { .col = MATRIX_COLS - 1, .row = 0 },
  { .col = MATRIX_COLS - 1, .row = MATRIX_ROWS - 1 },
};
#endif

__attribute__ ((weak))
bool process_record_keymap(uint16_t keycode, keyrecord_t *record) {
  return true;
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
  case OSLINUX:
    current_os = _OS_LINUX;
    return false;
  case OSMACOS:
    current_os = _OS_MACOS;
    return false;
  case OSWIN:
    current_os = _OS_WIN;
    return false;
  }

#ifdef CORNER_RESET_ENABLE
  for (int i = 0; i < 4; i += 1) {
    keypos_t boot_keypos = boot_keypositions[i];
    if (boot_keypos.col == record->event.key.col && boot_keypos.row == record->event.key.row) {
      if (record->event.pressed) {
        quarter_count += 1;
        if (quarter_count == 4) {
          reset_keyboard();
        }
      } else {
        quarter_count -= 1;
      }
    }
  }
#endif

  return process_record_keymap(keycode, record);
}

#ifdef COMBO_ENABLE
const uint16_t PROGMEM dsk_lower_left_combo[] = {KC_J, KC_K, COMBO_END};
const uint16_t PROGMEM dsk_lower_right_combo[] = {KC_M, KC_W, COMBO_END};
const uint16_t PROGMEM dsk_lower_lead_combo[] = {KC_SCLN, KC_Q, COMBO_END};

__attribute__ ((weak))
combo_t key_combos[COMBO_COUNT] = {
  USER_KEY_COMBOS,
};

__attribute__ ((weak))
void process_combo_event_keymap(uint16_t combo_index, bool pressed) {
}

void process_combo_event(uint16_t combo_index, bool pressed) {
  switch(combo_index) {
    case DESKTOP_GO_LEFT:
      if (pressed) {
        switch(current_os) {
          case _OS_LINUX:
            tap_code16(CODE16_LINUX_DESKTOP_LEFT);
            break;
          case _OS_MACOS:
            tap_code16(CODE16_MACOS_DESKTOP_LEFT);
            break;
          case _OS_WIN:
            tap_code16(CODE16_WIN_DESKTOP_LEFT);
            break;
        }
      }
      break;
    case DESKTOP_GO_RIGHT:
      if (pressed) {
        switch(current_os) {
          case _OS_LINUX:
            tap_code16(CODE16_LINUX_DESKTOP_RIGHT);
            break;
          case _OS_MACOS:
            tap_code16(CODE16_MACOS_DESKTOP_RIGHT);
            break;
          case _OS_WIN:
            tap_code16(CODE16_WIN_DESKTOP_RIGHT);
            break;
        }
      }
      break;
    case LEAD:
      if (pressed) {
#ifdef LEADER_ENABLE
        leader_start();
#endif
      }
      break;
  }
  process_combo_event_keymap(combo_index, pressed);
}
#endif

#ifdef LEADER_ENABLE
__attribute__ ((weak))
void leader_end_keymap(void) {
}
void leader_end_user(void) {
  if (leader_sequence_two_keys(KC_K, KC_C)) { // mnemonic: Kubernetes Ctl
    SEND_STRING("kubectl");
  } else if (leader_sequence_two_keys(KC_K, KC_G)) { // mnemonic: Kubernetes Get
    SEND_STRING("kubectl get");
  } else if (leader_sequence_three_keys(KC_K, KC_G, KC_P)) { // mnemonic: Kubernetes Get Pods
    SEND_STRING("kubectl get pods");
  } else if (leader_sequence_two_keys(KC_N, KC_U)) { // mnemonic: Name, dvorak home row
    SEND_STRING("rgoulter");
  } else if (leader_sequence_two_keys(KC_N, KC_E)) { // mnemonic: Name, dvorak home row
    SEND_STRING("richard.goulter");
  } else if (leader_sequence_two_keys(KC_N, KC_O)) { // mnemonic: Name, dvorak home row
    SEND_STRING("richardgoulter");
  } else if (leader_sequence_two_keys(KC_H, KC_U)) { // mnemonic: Host, dvorak home row
    SEND_STRING("gaming-pc");
  } else if (leader_sequence_two_keys(KC_H, KC_E)) { // mnemonic: Host, dvorak home row
    SEND_STRING("cloud-vm");
  } else if (leader_sequence_one_key(KC_L)) {
        switch(current_os) {
          case _OS_LINUX:
            tap_code16(CODE16_LINUX_DESKTOP_LOCK);
            break;
          case _OS_MACOS:
            tap_code16(CODE16_MACOS_DESKTOP_LOCK);
            break;
          case _OS_WIN:
            tap_code16(CODE16_WIN_DESKTOP_LOCK);
            break;
        }
  }
  leader_end_keymap();
}
#endif
