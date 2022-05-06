#![no_main]
#![no_std]

#[cfg(keyboard_revision = "2020.1")]
pub mod rev2020_1;
#[cfg(keyboard_revision = "2021.1")]
pub mod rev2021_1;

pub mod direct_pin_matrix_lhs;
pub mod direct_pin_matrix_rhs;

