#!/usr/bin/env bash

set -ex

RUSTFLAGS='--cfg keyboard_revision="2021.1"'
export RUSTFLAGS

cargo build --bin keyberon-f4-split-dp --release
cargo build --bin keyberon-f4-split-dp --release --features "split-right" --no-default-features
cargo objcopy --bin keyberon-f4-split-dp --release -- -O binary keyberon-left.bin
cargo objcopy --bin keyberon-f4-split-dp --release --features "split-right" --no-default-features -- -O binary keyberon-right.bin


