# PyKey40,
# Requires CircuitPython 7.0.0 to support the RP2040 MCU

from kb import KMKKeyboard

from kmk.keys import KC
from kmk.modules.layers import Layers

keyboard = KMKKeyboard()
keyboard.modules.append(Layers())

XXXXXXX = KC.TRNS

keyboard.keymap = [
    [
        KC.N1,   KC.Q,     KC.W,    KC.E,    KC.R,    KC.T,    KC.Y,    KC.U,    KC.I,    KC.O,    KC.P,    KC.X,
        KC.N2,   KC.A,     KC.S,    KC.D,    KC.F,    KC.G,    KC.H,    KC.J,    KC.K,    KC.L,    KC.SCLN, KC.Y,
        KC.N3,   KC.Z,     KC.X,    KC.C,    KC.V,    KC.B,    KC.N,    KC.M,    KC.COMM, KC.DOT,  KC.SLSH, KC.Z,
        KC.N4,   KC.N1,    KC.N2,   KC.N3,   KC.N4,   KC.N5,   XXXXXXX, KC.N7,   KC.N8,   KC.N9,   KC.N0,   KC.W,
    ],
]

if __name__ == '__main__':
    keyboard.go()
