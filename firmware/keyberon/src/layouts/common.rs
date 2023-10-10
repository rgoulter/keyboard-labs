use keyberon::action::{
    d, k,
    Action::{NoOp, Trans},
    HoldTapConfig,
};
use usbd_human_interface_device::page::{Keyboard, Keyboard::*};

pub type CustomAction = ();
pub type Action = keyberon::action::Action<CustomAction, Keyboard>;
pub type HoldTapAction = keyberon::action::HoldTapAction<CustomAction, Keyboard>;

pub use crate::layouts::macros::{a, c, g, s, sk};

pub type Seg3 = [Action; 3];
pub type Seg4 = [Action; 4];
pub type Seg5 = [Action; 5];

pub const SEG3_TRANS: Seg3 = [Trans; 3];
pub const SEG3_NOOP: Seg3 = [NoOp; 3];
pub const SEG5_TRANS: Seg5 = [Trans; 5];
pub const SEG5_NOOP: Seg5 = [NoOp; 5];

pub enum Row10 {
    Row10([Action; 10]),
    TwoSeg5(Seg5, Seg5),
    LHS(Seg5),
    RHS(Seg5),
}

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

pub const SEG5_DVORAK_LHS1: Seg5 = [k(Apostrophe), k(Comma), k(Dot), k(P), k(Y)];
pub const SEG5_DVORAK_RHS1: Seg5 = [k(F), k(G), k(C), k(R), k(L)];

pub const SEG5_DVORAK_LHS2: Seg5 = [a!(A), g!(O), c!(E), s!(U), k(I)];
pub const SEG5_DVORAK_RHS2: Seg5 = [k(D), s!(H), c!(T), g!(N), a!(S)];

pub const SEG5_DVORAK_LHS3: Seg5 = [k(Semicolon), k(Q), k(J), k(K), k(X)];
pub const SEG5_DVORAK_RHS3: Seg5 = [k(B), k(M), k(W), k(V), k(Z)];

pub const SEG5_QWERTY_LHS1: Seg5 = [k(Q), k(W), k(E), k(R), k(T)];
pub const SEG5_QWERTY_RHS1: Seg5 = [k(Y), k(U), k(I), k(O), k(P)];

pub const SEG5_QWERTY_LHS2: Seg5 = [k(A), k(S), k(D), k(F), k(G)];
pub const SEG5_QWERTY_RHS2: Seg5 = [k(H), k(J), k(K), k(L), k(Semicolon)];

pub const SEG5_QWERTY_LHS3: Seg5 = [k(Z), k(X), k(C), k(V), k(B)];
pub const SEG5_QWERTY_RHS3: Seg5 = [k(N), k(M), k(Comma), k(Dot), k(ForwardSlash)];

pub const SEG5_NAV1: Seg5 = SEG5_NOOP;
pub const SEG5_NAV2: Seg5 = [
    k(LeftArrow),
    k(DownArrow),
    k(UpArrow),
    k(RightArrow),
    k(CapsLock),
];
pub const SEG5_NAV3: Seg5 = [k(Home), k(PageDown), k(PageUp), k(End), k(Insert)];

pub const SEG5_MEDIA1: Seg5 = SEG5_NOOP;
pub const SEG5_MEDIA2: Seg5 = SEG5_NOOP;
pub const SEG5_MEDIA3: Seg5 = [d(0), d(1), NoOp, NoOp, NoOp];
pub const SEG3_MEDIA4: Seg3 = SEG3_NOOP;

pub const SEG5_MOUSE1: Seg5 = SEG5_NOOP;
pub const SEG5_MOUSE2: Seg5 = SEG5_NOOP;
pub const SEG5_MOUSE3: Seg5 = SEG5_NOOP;
pub const SEG3_MOUSE4: Seg3 = SEG3_NOOP;

pub const SEG5_NUM1: Seg5 = [
    k(LeftBrace),
    k(Keyboard7),
    k(Keyboard8),
    k(Keyboard9),
    k(RightBrace),
];
pub const SEG5_NUM2: Seg5 = [k(Grave), k(Keyboard4), k(Keyboard5), k(Keyboard6), k(Equal)];
pub const SEG5_NUM3: Seg5 = [
    k(ForwardSlash),
    k(Keyboard1),
    k(Keyboard2),
    k(Keyboard3),
    k(Backslash),
];
pub const SEG3_NUM4: Seg3 = [k(Dot), k(Keyboard0), k(Minus)];

pub const SEG5_SYM1: Seg5 = [
    sk!(LeftBrace),
    sk!(Keyboard7),
    sk!(Keyboard8),
    sk!(Keyboard9),
    sk!(RightBrace),
];
pub const SEG5_SYM2: Seg5 = [
    sk!(Grave),
    sk!(Keyboard4),
    sk!(Keyboard5),
    sk!(Keyboard6),
    sk!(Equal),
];
pub const SEG5_SYM3: Seg5 = [
    sk!(ForwardSlash),
    sk!(Keyboard1),
    sk!(Keyboard2),
    sk!(Keyboard3),
    sk!(Backslash),
];
pub const SEG3_SYM4: Seg3 = [sk!(Dot), sk!(Keyboard0), sk!(Minus)];

pub const SEG5_FUN1: Seg5 = [k(F12), k(F7), k(F8), k(F9), NoOp];
pub const SEG5_FUN2: Seg5 = [k(F11), k(F4), k(F5), k(F6), NoOp];
pub const SEG5_FUN3: Seg5 = [k(F10), k(F1), k(F2), k(F3), NoOp];
pub const SEG3_FUN4: Seg3 = [NoOp, NoOp, NoOp];
