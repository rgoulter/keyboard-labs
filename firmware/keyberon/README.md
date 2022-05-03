There is keyboard firmware written in Rust using the [keyberon](https://github.com/TeXitoi/keyberon)
firmware.

Currently supports:

- X-1 "MiniF4-36"

## Prerequisites

#### Using `rustup`

Install `rustup`:

```shell
curl https://sh.rustup.rs -sSf | sh
```

or using `nix`:

```
nix shell nixpkgs#rustup
rustup install stable
rustup default stable
```

then install the rust toolchain:

```shell
rustup target add thumbv7em-none-eabihf
rustup component add llvm-tools-preview
cargo install cargo-binutils
```

## Compiling

Compile the firmware, for each half:

- For the X-1 "MiniF4-36", the environment variable
  `MINIF4_36_REVISION` must be set to `2020.1` or
  `2021.1`, depending on the revision of the X-1 PCB.

The left half is built with:

```shell
cargo objcopy --bin keyberon-f4-split-dp --release -- -O binary keyberon-left.bin
```

The right half is built with:

```shell
cargo objcopy --bin keyberon-f4-split-dp --release --features "split-right" --no-default-features -- -O binary keyberon-right.bin
```

The script `build-and-objcopy.sh` will build the firmware for both halves.

## Flashing

#### Using DFU

Put the development board in DFU mode by pushing reset while pushing
boot, and then release boot.

Then flash it with:

```shell
dfu-util -d 0483:df11 -a 0 --dfuse-address 0x08000000 -D keyberon-left.bin
```

#### Using `stlink`

With an STLink device connected to the SWD pads of the development board,
flash with:

```
st-flash write <firmware>.bin 0x8000000
```
