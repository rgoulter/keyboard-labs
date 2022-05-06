#!/usr/bin/env bash

set -ex

export MINIF4_36_REVISION=2020.1
cargo build --bin minif4-36-rev2020_1-lhs --release
cargo build --bin minif4-36-rev2020_1-rhs --release
