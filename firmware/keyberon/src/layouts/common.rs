use keyberon::action::{
    Action::{NoOp, Trans},
    HoldTapConfig,
};
use keyberon::chording::ChordDef;
use usbd_human_interface_device::page::Keyboard;

pub use crate::layouts::macros::{a, c, g, s, sk};

pub mod segments;

pub use segments::*;

pub type CustomAction = ();

pub type Action = keyberon::action::Action<CustomAction, Keyboard>;

pub type HoldTapAction = keyberon::action::HoldTapAction<CustomAction, Keyboard>;

/// Alias of keyberon::layout::Layers, using CustomAction, and usb-human-interface-device's Keyboard.
pub type Layers<const C: usize, const R: usize, const L: usize> =
    keyberon::layout::Layers<C, R, L, CustomAction, Keyboard>;

/// Alias of keyberon::layout::Layout, using CustomAction, and usb-human-interface-device's Keyboard.
pub type Layout<const C: usize, const R: usize, const L: usize> =
    keyberon::layout::Layout<C, R, L, CustomAction, Keyboard>;

pub enum Row6 {
    Row6([Action; 6]),
    TwoSeg3(Seg3, Seg3),
    LHS(Seg3),
    RHS(Seg3),
}

impl Row6 {
    pub const fn into_array_6(self) -> [Action; 6] {
        match self {
            Row6::Row6(a) => a,
            Row6::TwoSeg3([a1, a2, a3], [a4, a5, a6]) => [a1, a2, a3, a4, a5, a6],
            Row6::LHS(seg3) => Row6::TwoSeg3(seg3, SEG3_NOOP).into_array_6(),
            Row6::RHS(seg3) => Row6::TwoSeg3(SEG3_NOOP, seg3).into_array_6(),
        }
    }
}

pub enum Row10 {
    Row10([Action; 10]),
    TwoSeg5(Seg5, Seg5),
    LHS(Seg5),
    RHS(Seg5),
}

impl Row10 {
    pub const fn into_array_10(self) -> [Action; 10] {
        match self {
            Row10::Row10(a) => a,
            Row10::TwoSeg5([a1, a2, a3, a4, a5], [a6, a7, a8, a9, a10]) => {
                [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10]
            }
            Row10::LHS(seg5) => Row10::TwoSeg5(seg5, SEG5_NOOP).into_array_10(),
            Row10::RHS(seg5) => Row10::TwoSeg5(SEG5_NOOP, seg5).into_array_10(),
        }
    }
}

pub enum Row12 {
    Row12([Action; 12]),
    TwoSeg6(Seg6, Seg6),
    TwoSeg5I(Action, Seg5, Seg5, Action),
    TwoSeg5O(Seg5, Action, Action, Seg5),
}

impl Row12 {
    pub const fn into_array_12(self) -> [Action; 12] {
        match self {
            Self::Row12(a) => a,
            Self::TwoSeg6([a1, a2, a3, a4, a5, a6], [a7, a8, a9, a10, a11, a12]) => {
                [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12]
            }
            Self::TwoSeg5I(a1, [a2, a3, a4, a5, a6], [a7, a8, a9, a10, a11], a12) => {
                [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12]
            }
            Self::TwoSeg5O([a1, a2, a3, a4, a5], a6, a7, [a8, a9, a10, a11, a12]) => {
                [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12]
            }
        }
    }
}

pub const fn th_lk<'a>(layer: usize, key: Keyboard) -> HoldTapAction {
    HoldTapAction {
        timeout: 200,
        config: HoldTapConfig::Default,
        tap_hold_interval: 0,
        hold: Action::Layer(layer),
        tap: Action::KeyCode(key),
    }
}

pub const _______: Action = Trans;

// construct the ChordDefs array,
// by constructing virtual rows which will get
// appended to the keymap layer.
//
// C: num columns
// R: num rows
// N: num chords
pub const fn chord_coordinates_along_rows<const C: usize, const R: usize, const N: usize>(
    coords: [&'static [(u8, u8)]; N],
) -> [ChordDef; N] {
    let mut res: [ChordDef; N] = [((255, 255), &[(255, 255)]); N];
    let mut idx = 0;
    while idx < N {
        let row_idx = (idx / C) as u8;
        let col_idx = (idx % C) as u8;
        res[idx] = ((R as u8 + row_idx, col_idx), coords[idx]);
        idx += 1;
    }
    res
}

// Construct the chord rows to append to the layer.
//
// C: number of columns.
// CR: number of chord rows.
// N: number of chords.
pub const fn chord_rows<const C: usize, const CR: usize, const N: usize>(
    chords: [Action; N],
) -> [[Action; C]; CR] {
    let mut res = [[NoOp; C]; CR];
    let mut chord_idx = 0;
    while chord_idx < N {
        let cr = chord_idx / C;
        let i = chord_idx % C;
        res[cr][i] = chords[chord_idx];
        chord_idx += 1;
    }
    res
}

pub const fn combine_layer_and_chords<
    const C: usize,
    const LR: usize,
    const CR: usize,
    const R: usize,
>(
    layer: [[Action; C]; LR],
    chord_rows: [[Action; C]; CR],
) -> [[Action; C]; R] {
    let mut res = [[NoOp; C]; R];
    let mut idx = 0;
    while idx < LR {
        res[idx] = layer[idx];
        idx += 1;
    }
    while idx < LR + CR {
        res[idx] = chord_rows[idx - LR];
        idx += 1;
    }
    res
}
