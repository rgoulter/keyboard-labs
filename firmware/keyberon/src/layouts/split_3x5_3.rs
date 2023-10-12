pub mod rgoulter;

use crate::layouts::common::{Action as A, Row10, Row6};
use keyberon::action::Action::NoOp;

pub struct Split3x5_3([A; 10], [A; 10], [A; 10], [A; 6]);

impl Split3x5_3 {
    pub const fn from_rows(row1: Row10, row2: Row10, row3: Row10, row4: Row6) -> Split3x5_3 {
        Split3x5_3(
            row1.into_array_10(),
            row2.into_array_10(),
            row3.into_array_10(),
            row4.into_array_6(),
        )
    }

    #[rustfmt::skip]
    pub const fn into_keymap_layer_10x4(self, chord_row: [A; 10]) -> [[A; 10]; 4 + 1] {
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
            chord_row,
        ]
    }
}
