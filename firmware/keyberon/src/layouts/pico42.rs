use crate::layouts::common::{chord_rows, combine_layer_and_chords, Action, Row10, Row12};
use crate::layouts::split_3x5_3::Split3x5_3;
use keyberon::action::Action::NoOp;

#[derive(Copy, Clone)]
pub struct Pico42(
    pub [Action; 10],
    pub [Action; 10],
    pub [Action; 10],
    pub [Action; 12],
);

impl Pico42 {
    pub const fn noop() -> Self {
        Self([NoOp; 10], [NoOp; 10], [NoOp; 10], [NoOp; 12])
    }

    pub const fn from_rows(row1: Row10, row2: Row10, row3: Row10, row4: Row12) -> Self {
        Self(
            row1.into_array_10(),
            row2.into_array_10(),
            row3.into_array_10(),
            row4.into_array_12(),
        )
    }

    pub const fn from_split3x5_3(split3x5_3: Split3x5_3) -> Self {
        let Split3x5_3(row1, row2, row3, row4_6) = split3x5_3;
        let [r41, r42, r43, r44, r45, r46] = row4_6;
        let row4_12 = [
            NoOp, NoOp, NoOp, r41, r42, r43, r44, r45, r46, NoOp, NoOp, NoOp,
        ];
        Self(row1, row2, row3, row4_12)
    }

    #[rustfmt::skip]
    pub const fn into_keymap_layer_12x4(self) -> [[Action; 12]; 4] {
        let Self(
            [k11, k12, k13, k14, k15,             k18, k19, k110, k111, k112],
            [k21, k22, k23, k24, k25,             k28, k29, k210, k211, k212],
            [k31, k32, k33, k34, k35,             k38, k39, k310, k311, k312],
            [k41, k42, k43, k44, k45, k46,  k47,  k48, k49, k410, k411, k412],
        ) = self;
        [
            [k11, k12, k13, k14, k15, NoOp, NoOp, k18, k19, k110, k111, k112],
            [k21, k22, k23, k24, k25, NoOp, NoOp, k28, k29, k210, k211, k212],
            [k31, k32, k33, k34, k35, NoOp, NoOp, k38, k39, k310, k311, k312],
            [k41, k42, k43, k44, k45, k46,  k47,  k48, k49, k410, k411, k412],
        ]
    }

    #[rustfmt::skip]
    pub const fn into_keymap_layer_12x4_swapped_thumbs(self) -> [[Action; 12]; 4] {
        // Swap the RHS thumb keys around
        let Self(
            [k11, k12, k13, k14, k15,             k18, k19, k110, k111, k112],
            [k21, k22, k23, k24, k25,             k28, k29, k210, k211, k212],
            [k31, k32, k33, k34, k35,             k38, k39, k310, k311, k312],
            [k41, k42, k43, k44, k45, k46,  k47,  k48, k49, k410, k411, k412],
        ) = self;
        [
            [k11, k12, k13, k14, k15, NoOp, NoOp, k18, k19, k110, k111, k112],
            [k21, k22, k23, k24, k25, NoOp, NoOp, k28, k29, k210, k211, k212],
            [k31, k32, k33, k34, k35, NoOp, NoOp, k38, k39, k310, k311, k312],
            [k41, k42, k43, k44, k45, k46,  k49,  k47, k48, k410, k411, k412],
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
    keymap_parts: [(Pico42, [Action; NC]); NL],
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

// Constructs the layers of the [[[Action; cols]; rows]; layers] array.
//
// NL: num layers
// NC: num chords
// RR: num chord rows
// R: num keymap rows + chord rows
pub const fn compile_split3x5_3_layer_parts_12x4<
    const NL: usize,
    const NC: usize,
    const CR: usize,
    const R: usize,
>(
    keymap_parts: [(Split3x5_3, [Action; NC]); NL],
) -> [[[Action; 12]; R]; NL] {
    let mut res = [[[NoOp; 12]; R]; NL];
    let mut idx = 0;
    while idx < NL {
        let (keymap_split3x5_3, chords) = keymap_parts[idx];

        let keymap = Pico42::from_split3x5_3(keymap_split3x5_3);
        let keymap_layer = keymap.into_keymap_layer_12x4();
        let crows: [[Action; 12]; CR] = chord_rows(chords);
        res[idx] = combine_layer_and_chords(keymap_layer, crows);

        idx += 1;
    }
    res
}

// Constructs the layers of the [[[Action; cols]; rows]; layers] array.
//
// NL: num layers
// NC: num chords
// RR: num chord rows
// R: num keymap rows + chord rows
pub const fn compile_split3x5_3_layer_parts_12x4_swapped_thumbs<
    const NL: usize,
    const NC: usize,
    const CR: usize,
    const R: usize,
>(
    keymap_parts: [(Split3x5_3, [Action; NC]); NL],
) -> [[[Action; 12]; R]; NL] {
    let mut res = [[[NoOp; 12]; R]; NL];
    let mut idx = 0;
    while idx < NL {
        let (keymap_split3x5_3, chords) = keymap_parts[idx];

        let keymap = Pico42::from_split3x5_3(keymap_split3x5_3);
        let keymap_layer = keymap.into_keymap_layer_12x4_swapped_thumbs();
        let crows: [[Action; 12]; CR] = chord_rows(chords);
        res[idx] = combine_layer_and_chords(keymap_layer, crows);

        idx += 1;
    }
    res
}
