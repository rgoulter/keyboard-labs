pub mod rgoulter;

use crate::layouts::common::{chord_rows, combine_layer_and_chords, Action as A, Row10, Row6};
use keyberon::action::Action::NoOp;

#[derive(Copy, Clone)]
pub struct Split3x5_3([A; 10], [A; 10], [A; 10], [A; 6]);

impl Split3x5_3 {
    pub const fn noop() -> Split3x5_3 {
        Self([NoOp; 10], [NoOp; 10], [NoOp; 10], [NoOp; 6])
    }
    pub const fn from_rows(row1: Row10, row2: Row10, row3: Row10, row4: Row6) -> Split3x5_3 {
        Split3x5_3(
            row1.into_array_10(),
            row2.into_array_10(),
            row3.into_array_10(),
            row4.into_array_6(),
        )
    }

    #[rustfmt::skip]
    pub const fn into_keymap_layer_10x4(self) -> [[A; 10]; 4] {
        let Split3x5_3(
            [k11, k12, k13, k14, k15,     k16, k17, k18, k19, k110],
            [k21, k22, k23, k24, k25,     k26, k27, k28, k29, k210],
            [k31, k32, k33, k34, k35,     k36, k37, k38, k39, k310],
                      [k41, k42, k43,     k44, k45, k46],
        ) = self;
        [
            [k11,  k12,  k13, k14, k15,     k16, k17, k18, k19, k110],
            [k21,  k22,  k23, k24, k25,     k26, k27, k28, k29, k210],
            [k31,  k32,  k33, k34, k35,     k36, k37, k38, k39, k310],
            [NoOp, NoOp, k41, k42, k43,     k44, k45, k46, NoOp, NoOp],
        ]
    }
}

// Constructs the layers of the [[[Action; cols]; rows]; layers] array.
//
// NL: num layers
// NC: num chords
// RR: num chord rows
// R: num keymap rows + chord rows
pub const fn compile_layer_parts_10x4<
    const NL: usize,
    const NC: usize,
    const CR: usize,
    const R: usize,
>(
    keymap_parts: [(Split3x5_3, [A; NC]); NL],
) -> [[[A; 10]; R]; NL] {
    let mut res = [[[NoOp; 10]; R]; NL];
    let mut idx = 0;
    while idx < NL {
        let (keymap, chords) = keymap_parts[idx];

        let keymap_layer = keymap.into_keymap_layer_10x4();
        let crows: [[A; 10]; CR] = chord_rows(chords);
        res[idx] = combine_layer_and_chords(keymap_layer, crows);

        idx += 1;
    }
    res
}
