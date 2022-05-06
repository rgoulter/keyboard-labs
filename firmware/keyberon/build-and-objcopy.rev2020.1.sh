#!/usr/bin/env bash

set -ex

cargo build --bin minif4-36-rev2020_1-lhs --release
cargo build --bin minif4-36-rev2020_1-rhs --release
