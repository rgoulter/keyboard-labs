use crate::layouts::common::{chord_rows, combine_layer_and_chords, Action, Row12};
use keyberon::action::Action::NoOp;

#[derive(Copy, Clone)]
pub struct PlanckMit(
    pub [Action; 12],
    pub [Action; 12],
    pub [Action; 12],
    pub [Action; 11],
);

impl PlanckMit {
    pub const fn noop() -> Self {
        Self([NoOp; 12], [NoOp; 12], [NoOp; 12], [NoOp; 11])
    }

    pub const fn from_rows(row1: Row12, row2: Row12, row3: Row12, row4: [Action; 11]) -> Self {
        Self(
            row1.into_array_12(),
            row2.into_array_12(),
            row3.into_array_12(),
            row4,
        )
    }

    #[rustfmt::skip]
    pub const fn into_keymap_layer_12x4(self) -> [[Action; 12]; 4] {
        let Self(
            [k11, k12, k13, k14, k15, k16, k17,  k18, k19, k110, k111, k112],
            [k21, k22, k23, k24, k25, k26, k27,  k28, k29, k210, k211, k212],
            [k31, k32, k33, k34, k35, k36, k37,  k38, k39, k310, k311, k312],
            [k41, k42, k43, k44, k45, k46,       k48, k49, k410, k411, k412],
        ) = self;
        [
            [k11, k12, k13, k14, k15, k16, k17,  k18, k19, k110, k111, k112],
            [k21, k22, k23, k24, k25, k26, k27,  k28, k29, k210, k211, k212],
            [k31, k32, k33, k34, k35, k36, k37,  k38, k39, k310, k311, k312],
            [k41, k42, k43, k44, k45, k46, NoOp, k48, k49, k410, k411, k412],
        ]
    }
}

// Constructs the layers of the [[[Action; cols]; rows]; layers] array.
//
// NL: num layers
// NC: num chords
// RR: num chord rows
// R: num keymap rows + chord rows
pub const fn compile_layer_parts_12x4<
    const NL: usize,
    const NC: usize,
    const CR: usize,
    const R: usize,
>(
    keymap_parts: [(PlanckMit, [Action; NC]); NL],
) -> [[[Action; 12]; R]; NL] {
    let mut res = [[[NoOp; 12]; R]; NL];
    let mut idx = 0;
    while idx < NL {
        let (keymap, chords) = keymap_parts[idx];

        let keymap_layer = keymap.into_keymap_layer_12x4();
        let crows: [[Action; 12]; CR] = chord_rows(chords);
        res[idx] = combine_layer_and_chords(keymap_layer, crows);

        idx += 1;
    }
    res
}
