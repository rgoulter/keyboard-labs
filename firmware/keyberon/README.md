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

#### Using `nix`

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

## Using `nix`

```shell
nix build .#keyberon-firmware-uf2
```

puts the `.uf2` files for all the firmware (in `src/bin`) in `result/bin/`.

## Using `cargo`

Compile the firmware:

```shell
cargo objcopy --bin <firmware src> --release -- -O binary firmware.bin
```

where `<firmware src>` is one of `src/bin/<firmware src>.rs`, e.g.:

- `minif4-36-rev2020_1-lhs`
- `minif4-36-rev2020_1-rhs`
- `minif4-36-rev2021_1-lhs`
- `minif4-36-rev2021_1-rhs`
- `x_2-rev2021_1`

## Flashing

#### Using UF2

I recommend flashing [tinyuf2](https://github.com/adafruit/tinyuf2)
onto the dev board. This makes flashing the keyberon firmware as easy
as copying the file onto a flashdrive.

The `bootloaders.nix` file in the `scripts/` directory in the repository root
has a Nix expression for the bootloader. e.g. to build tinyuf2 for the
WeAct Studio MiniF4 "Blackpill", with STM32F401xx MCU:

```
nix-build bootloaders.nix -A stm32f401.tinyuf2
st-flash write result/tinyuf2-stm32f401_blackpill.bin 0x8000000
```

#### Using DFU

Put the development board in DFU mode by pushing reset while pushing
boot, and then release boot.

Then flash it with:

```shell
dfu-util -d 0483:df11 -a 0 --dfuse-address 0x08000000 -D <firmware>.bin
```

#### Using `stlink`

With an STLink device connected to the SWD pads of the development board,
flash with:

```
st-flash write <firmware>.bin 0x8000000
```
