#[cfg(feature = "split-left")]
mod pin_layout_lhs;
#[cfg(feature = "split-right")]
mod pin_layout_rhs;

#[cfg(feature = "split-left")]
use pin_layout_lhs as pin_layout;

#[cfg(feature = "split-right")]
use pin_layout_rhs as pin_layout;

pub use pin_layout::{direct_pin_matrix_for_peripherals, DirectPins5x4};
