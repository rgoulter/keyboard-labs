# PyKey40,
# Requires CircuitPython 7.0.0 to support the RP2040 MCU

from kb import KMKKeyboard

from kmk.keys import KC
from kmk.modules.layers import Layers

keyboard = KMKKeyboard()
keyboard.modules.append(Layers())

LOWER = KC.MO(1) # LHS; sym
RAISE = KC.MO(2) # RHS; num
XXXXXXX = KC.TRNS

keyboard.keymap = [
    # Qwerty
    # ,-----------------------------------------------------------------------------------.
    # | Tab  |   Q  |   W  |   E  |   R  |   T  |   Y  |   U  |   I  |   O  |   P  | Bksp |
    # |------+------+------+------+------+------+------+------+------+------+------+------|
    # | Esc  |   A  |   S  |   D  |   F  |   G  |   H  |   J  |   K  |   L  |   ;  |  "   |
    # |------+------+------+------+------+------+------+------+------+------+------+------|
    # | Shift|   Z  |   X  |   C  |   V  |   B  |   N  |   M  |   ,  |   .  |   /  |Enter |
    # |------+------+------+------+------+------+------+------+------+------+------+------|
    # | BLTog| Ctrl | Alt  | GUI  |Lower |    Space    |Raise | Left | Down |  Up  |Right |
    # `-----------------------------------------------------------------------------------'
    [
        KC.TAB,   KC.Q,     KC.W,    KC.E,    KC.R,    KC.T,    KC.Y,    KC.U,    KC.I,    KC.O,    KC.P,    KC.BSPC, 
        KC.ESC,   KC.A,     KC.S,    KC.D,    KC.F,    KC.G,    KC.H,    KC.J,    KC.K,    KC.L,    KC.SCLN, KC.QUOT, 
        KC.LSFT,  KC.Z,     KC.X,    KC.C,    KC.V,    KC.B,    KC.N,    KC.M,    KC.COMM, KC.DOT,  KC.SLSH, KC.ENTER, 
        KC.GRV,   KC.LCTRL, KC.LGUI, KC.LALT, LOWER,   KC.SPC,  XXXXXXX, RAISE,   KC.LEFT, KC.DOWN, KC.UP, KC.RIGHT,      
    ],

    # Lower, LHS, Symbols
    # ,-----------------------------------------------------------------------------------.
    # |   ~  |   !  |   @  |   #  |   $  |   %  |   ^  |   &  |   *  |   (  |   )  | Bksp |
    # |------+------+------+------+------+------+------+------+------+------+------+------|
    # | Del  |  F1  |  F2  |  F3  |  F4  |  F5  |  F6  |   _  |   +  |   {  |   }  |  |   |
    # |------+------+------+------+------+------+------+------+------+------+------+------|
    # |      |  F7  |  F8  |  F9  |  F10 |  F11 |  F12 |ISO ~ |ISO | | Home | End  |      |
    # |------+------+------+------+------+------+------+------+------+------+------+------|
    # |      |      |      |      |      |             |      | Next | Vol- | Vol+ | Play |
    # `-----------------------------------------------------------------------------------'
    [
        KC.TILD, KC.EXLM, KC.AT,   KC.HASH, KC.DLR,  KC.PERC,   KC.CIRC, KC.AMPR, KC.ASTR, KC.LPRN, KC.RPRN, XXXXXXX,
        KC.DEL,  KC.F1,   KC.F2,   KC.F3,   KC.F4,   KC.F5,     KC.F6,   KC.UNDS, KC.PLUS, KC.LCBR, KC.RCBR, KC.PIPE,
        XXXXXXX, KC.F7,   KC.F8,   KC.F9,   KC.F10,  KC.F11,    KC.F12,  XXXXXXX, XXXXXXX, KC.HOME, KC.END,  XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
    ],

    # Raise, RHS, Numbers
    # ,-----------------------------------------------------------------------------------.
    # |   `  |   1  |   2  |   3  |   4  |   5  |   6  |   7  |   8  |   9  |   0  | Bksp |
    # |------+------+------+------+------+------+------+------+------+------+------+------|
    # | Del  |  F1  |  F2  |  F3  |  F4  |  F5  |  F6  |   -  |   =  |   [  |   ]  |  \   |
    # |------+------+------+------+------+------+------+------+------+------+------+------|
    # |      |  F7  |  F8  |  F9  |  F10 |  F11 |  F12 |ISO # |ISO / |Pg Up |Pg Dn |      |
    # |------+------+------+------+------+------+------+------+------+------+------+------|
    # |      |      |      |      |      |             |      | Next | Vol- | Vol+ | Play |
    # `-----------------------------------------------------------------------------------'
    [
        KC.GRV,  KC.N1,   KC.N2,   KC.N3,   KC.N4,   KC.N5,   KC.N6,   KC.N7,   KC.N8,   KC.N9,   KC.N0,   KC.BSPC,
        KC.DEL,  KC.F1,   KC.F2,   KC.F3,   KC.F4,   KC.F5,   KC.F6,   KC.MINS, KC.EQL,  KC.LBRC, KC.RBRC, KC.BSLS,
        XXXXXXX, KC.F7,   KC.F8,   KC.F9,   KC.F10,  KC.F11,  KC.F12,  XXXXXXX, XXXXXXX, KC.PGUP, KC.PGDN, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
    ],

]

if __name__ == '__main__':
    keyboard.go()
