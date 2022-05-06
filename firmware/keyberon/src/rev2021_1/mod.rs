#[cfg(feature = "split-left")]
mod pin_layout_lhs;
#[cfg(feature = "split-right")]
mod pin_layout_rhs;

#[cfg(feature = "split-left")]
use pin_layout_lhs as pin_layout_lhs_or_rhs;

#[cfg(feature = "split-right")]
use pin_layout_rhs as pin_layout_lhs_or_rhs;

pub use pin_layout_lhs_or_rhs::{direct_pin_matrix_for_peripherals_lhs_or_rhs, DirectPins5x4LhsOrRhs};
