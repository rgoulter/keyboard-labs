#!/usr/bin/env bash

set -ex

export MINIF4_36_REVISION=2021.1
cargo build --bin minif4-36-rev2021_1-lhs --release
cargo build --bin minif4-36-rev2021_1-rhs --release --features "split-right" --no-default-features

cargo objcopy --bin minif4-36-rev2021_1-lhs --release -- -O binary keyberon-left.bin
cargo objcopy --bin minif4-36-rev2021_1-rhs --release --features "split-right" --no-default-features -- -O binary keyberon-right.bin

