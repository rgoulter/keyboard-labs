// More/less Dvorak without home row modifiers.
[_GAME_ALT] = LAYOUT_split_3x5_3_wrapper( \
   KC_X,    KC_PGDN,  KC_A,    KC_PGUP, _______,          KC_NUM,  _______, _______, _______, _______,
   KC_I,    KC_E,     KC_O,    KC_U,    _______,          KC_KP_0, KC_J,    KC_K,    KC_L,    KC_SLSH,
   _______, _______,  _______, _______, _______,          KC_B,    KC_M,    _______, _______, _______,
                      _______, KC_END,  KC_L,             KC_B,    KC_M,    BASE
),

// "Default" controls for Tomb Raider 3.
// However, since stuff like Ctrl, Space, Win conflict with desktop controls,
// best to avoid.
[_GAME_DF] = LAYOUT_split_3x5_3_wrapper( \
   KC_ESC,  KC_PGDN, KC_UP,   KC_PGUP,   _______,           KC_NUM,  _______,  _______, _______, _______,
   KC_LSFT, KC_LEFT, KC_DOWN, KC_RIGHT,  _______,           KC_KP_0, KC_LCTL,  KC_SPC,  KC_LALT, KC_SLSH,
   _______, _______, _______, _______,   _______,           KC_DOT,  KC_COMMA, _______, _______, _______,
                     _______, KC_END,    KC_LALT,           KC_DOT,  KC_COMMA, BASE
),
