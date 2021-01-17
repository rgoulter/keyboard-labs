## Compiling

Install the rust toolchain

```shell
curl https://sh.rustup.rs -sSf | sh
rustup target add thumbv7em-none-eabihf
rustup component add llvm-tools-preview
cargo install cargo-binutils
```

Compile the firmware, for each half:

```shell
cargo objcopy --bin keyberon-f4-split-dp --release -- -O binary keyberon-left.bin
cargo objcopy --bin keyberon-f4-split-dp --release --features "split-right" --no-default-features -- -O binary keyberon-right.bin
```

## Flashing using DFU

Put the developement board in DFU mode by pushing reset while pushing
boot, and then release boot. Then flash it:
```shell
dfu-util -d 0483:df11 -a 0 --dfuse-address 0x08000000 -D keyberon-left.bin
```

