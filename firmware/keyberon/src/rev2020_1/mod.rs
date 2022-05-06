#[cfg(feature = "split-left")]
mod pin_layout_lhs;
#[cfg(feature = "split-right")]
mod pin_layout_rhs;

#[cfg(feature = "split-left")]
pub use pin_layout_lhs::{
  direct_pin_matrix_for_peripherals_lhs as direct_pin_matrix_for_peripherals_lhs_or_rhs,
  DirectPins5x4Lhs as DirectPins5x4LhsOrRhs,
};

#[cfg(feature = "split-right")]
pub use pin_layout_rhs::{
  direct_pin_matrix_for_peripherals_rhs as direct_pin_matrix_for_peripherals_lhs_or_rhs,
  DirectPins5x4Rhs as DirectPins5x4LhsOrRhs,
};
