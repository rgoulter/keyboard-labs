#!/usr/bin/env bash

set -ex

cargo build --bin minif4-36-rev2021_1-lhs --release
cargo build --bin minif4-36-rev2021_1-rhs --release

cargo objcopy --bin minif4-36-rev2021_1-lhs --release -- -O binary keyberon-left.bin
cargo objcopy --bin minif4-36-rev2021_1-rhs --release -- -O binary keyberon-right.bin
