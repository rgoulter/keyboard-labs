use keyberon::action::Action::{HoldTap, NoOp};
use keyberon::chording::ChordDef;
use usbd_human_interface_device::page::{Keyboard, Keyboard::*};

use crate::layouts::common;
use crate::layouts::common::{
    chord_coordinates_along_rows, chord_rows, combine_layer_and_chords, th_lk, Action,
    CustomAction, HoldTapAction, Row10, Row10::*, Row6, Row6::*, SEG3_NOOP,
};

use super::Split3x5_3;

const SP_NAVR: Action = HoldTap(&(Layers::NavR.th(Space)));
const TAB_MOUR: Action = HoldTap(&(Layers::MouseR.th(Tab)));
const ESC_MEDR: Action = HoldTap(&(Layers::MediaR.th(Escape)));

const BKSP_NSL: Action = HoldTap(&(Layers::NumSymL.th(DeleteBackspace)));
const ENT_NSSL: Action = HoldTap(&(Layers::ShiftedNumSymL.th(ReturnEnter)));
const DEL_FUNL: Action = HoldTap(&(Layers::FuncL.th(DeleteForward)));

pub const COLS: usize = 2 * 5;
pub const ROWS: usize = 4;
pub const NUM_CHORD_ROWS: usize = 1;
pub const ROWS_AND_MACROS: usize = ROWS + NUM_CHORD_ROWS;
pub const NUM_LAYERS: usize = 8;

pub type Keymap =
    keyberon::layout::Layers<COLS, ROWS_AND_MACROS, NUM_LAYERS, CustomAction, Keyboard>;
pub type Layout =
    keyberon::layout::Layout<COLS, ROWS_AND_MACROS, NUM_LAYERS, CustomAction, Keyboard>;

pub static LAYERS: Keymap = Layers::keymap();

pub const NUM_CHORDS: usize = 2;
// Position on the keyboard matrix
pub const CHORD_COORDINATES: [&'static [(u8, u8)]; NUM_CHORDS] = [
    &[(2, 2), (2, 3)],                                   // JK
    &[(2, COLS as u8 - 1 - 3), (2, COLS as u8 - 1 - 2)], // M,
];
pub const CHORDS: [ChordDef; NUM_CHORDS] = chord_coordinates_along_rows::<COLS, ROWS, NUM_CHORDS>(CHORD_COORDINATES);

enum Layers {
    BaseDsk,
    BaseQwerty,
    NavR,
    MouseR,
    MediaR,
    NumSymL,
    ShiftedNumSymL,
    FuncL,
}

impl Layers {
    const fn layer_num(&self) -> usize {
        match self {
            Self::BaseDsk => 0,
            Self::BaseQwerty => 1,
            Self::NavR => 2,
            Self::MediaR => 3,
            Self::MouseR => 4,
            Self::NumSymL => 5,
            Self::ShiftedNumSymL => 6,
            Self::FuncL => 7,
        }
    }
    const fn th(&self, k: Keyboard) -> HoldTapAction {
        th_lk(self.layer_num(), k)
    }

    const fn chord_rows(&self) -> [[Action; COLS]; 1] {
        match self {
            _ => chord_rows([
                crate::layouts::actions::LINUX_DESKTOP_LEFT,
                crate::layouts::actions::LINUX_DESKTOP_RIGHT,
            ]),
        }
    }

    const fn layer_keymap(&self) -> Split3x5_3 {
        match self {
            Self::BaseDsk => Split3x5_3::from_rows(
                TwoSeg5(common::SEG5_DVORAK_LHS1, common::SEG5_DVORAK_RHS1),
                TwoSeg5(common::SEG5_DVORAK_LHS2, common::SEG5_DVORAK_RHS2),
                TwoSeg5(common::SEG5_DVORAK_LHS3, common::SEG5_DVORAK_RHS3),
                Row6([TAB_MOUR, ESC_MEDR, SP_NAVR, BKSP_NSL, ENT_NSSL, DEL_FUNL]),
            ),
            Self::BaseQwerty => Split3x5_3::from_rows(
                TwoSeg5(common::SEG5_QWERTY_LHS1, common::SEG5_QWERTY_RHS1),
                TwoSeg5(common::SEG5_QWERTY_LHS2, common::SEG5_QWERTY_RHS2),
                TwoSeg5(common::SEG5_QWERTY_LHS3, common::SEG5_QWERTY_RHS3),
                Row6([TAB_MOUR, ESC_MEDR, SP_NAVR, BKSP_NSL, ENT_NSSL, DEL_FUNL]),
            ),
            Self::NavR => Split3x5_3::from_rows(
                Row10::RHS(common::SEG5_NAV1),
                Row10::RHS(common::SEG5_NAV2),
                Row10::RHS(common::SEG5_NAV3),
                Row6::RHS(SEG3_NOOP),
            ),
            Self::MediaR => Split3x5_3::from_rows(
                Row10::RHS(common::SEG5_MEDIA1),
                Row10::RHS(common::SEG5_MEDIA2),
                Row10::RHS(common::SEG5_MEDIA3),
                Row6::RHS(common::SEG3_MEDIA4),
            ),
            Self::MouseR => Split3x5_3::from_rows(
                Row10::RHS(common::SEG5_MOUSE1),
                Row10::RHS(common::SEG5_MOUSE2),
                Row10::RHS(common::SEG5_MOUSE3),
                Row6::RHS(common::SEG3_MOUSE4),
            ),
            Self::NumSymL => Split3x5_3::from_rows(
                Row10::LHS(common::SEG5_NUM1),
                Row10::LHS(common::SEG5_NUM2),
                Row10::LHS(common::SEG5_NUM3),
                Row6::LHS(common::SEG3_NUM4),
            ),
            Self::ShiftedNumSymL => Split3x5_3::from_rows(
                Row10::LHS(common::SEG5_SYM1),
                Row10::LHS(common::SEG5_SYM2),
                Row10::LHS(common::SEG5_SYM3),
                Row6::LHS(common::SEG3_SYM4),
            ),
            Self::FuncL => Split3x5_3::from_rows(
                Row10::LHS(common::SEG5_FUN1),
                Row10::LHS(common::SEG5_FUN2),
                Row10::LHS(common::SEG5_FUN3),
                Row6::LHS(common::SEG3_FUN4),
            ),
        }
    }

    const fn keymap() -> Keymap {
        let mut keymap = [[[NoOp; COLS]; ROWS_AND_MACROS]; NUM_LAYERS];
        let mut idx = 0;
        let layers = [
            Self::BaseDsk,
            Self::BaseQwerty,
            Self::NavR,
            Self::MediaR,
            Self::MouseR,
            Self::NumSymL,
            Self::ShiftedNumSymL,
            Self::FuncL,
        ];
        while idx < layers.len() {
            let layer = &layers[idx];
            let chord_rows = layer.chord_rows();
            keymap[layer.layer_num()] =
                combine_layer_and_chords(layer.layer_keymap().into_keymap_layer_10x4(), chord_rows);
            idx += 1;
        }
        keymap
    }
}
