{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    naersk = {
      url = "github:nmattia/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    fenix,
    flake-utils,
    naersk,
    nixpkgs,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      target = "thumbv7em-none-eabihf";
      toolchain = with fenix.packages.${system};
        combine [
          complete.llvm-tools-preview
          complete.rust-src
          default.rustfmt
          default.cargo
          default.rustc
          targets.${target}.latest.rust-std
        ];
    in let
      uf2conv = pkgs.callPackage ../../nix/pkgs/uf2conv {};
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.cargo-binutils
          pkgs.hidrd
          pkgs.rust-analyzer
          pkgs.usbutils
          toolchain
          uf2conv
        ];
        RUST_SRC_PATH = "${toolchain}/lib/rustlib/src";
        CARGO_BUILD_TARGET = target;
        CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER = "${pkgs.pkgsCross.aarch64-multiplatform.stdenv.cc}/bin/${target}-gcc";
        # Use memory.x for STM32F4xx for running on tinyuf2
        CARGO_TARGET_THUMBV7EM_NONE_EABIHF_RUSTFLAGS = "-C link-arg=--library-path=ld/stm32f4xx-tinyuf2";
      };

      packages = rec {
        keyberon-firmware-elf =
          (naersk.lib.${system}.override {
            cargo = toolchain;
            rustc = toolchain;
          })
          .buildPackage {
            src = ./.;
            CARGO_BUILD_TARGET = target;
            CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER = "${pkgs.pkgsCross.aarch64-multiplatform.stdenv.cc}/bin/${target}-gcc";
            # Use memory.x for STM32F4xx for running on tinyuf2
            CARGO_TARGET_THUMBV7EM_NONE_EABIHF_RUSTFLAGS = "-C link-arg=--library-path=ld/stm32f4xx-tinyuf2";
          };

        keyberon-firmware-bin = pkgs.runCommand "keyboard-labs-keyberon-firmware-bin" {} ''
          mkdir -p $out/bin
          export RUSTC=${toolchain}/bin/rustc

          ${pkgs.cargo-binutils}/bin/rust-objcopy \
            "${keyberon-firmware-elf}/bin/minif4-36-rev2021_1-lhs" \
            "--output-target" "binary" \
            "$out/bin/minif4-36-rev2021_1-lhs.bin"

          ${pkgs.cargo-binutils}/bin/rust-objcopy \
            "${keyberon-firmware-elf}/bin/minif4-36-rev2021_1-rhs" \
            "--output-target" "binary" \
            "$out/bin/minif4-36-rev2021_1-rhs.bin"

          ${pkgs.cargo-binutils}/bin/rust-objcopy \
            "${keyberon-firmware-elf}/bin/x_2-rev2021_1" \
            "--output-target" "binary" \
            "$out/bin/x_2-rev2021_1.bin"

          ${pkgs.cargo-binutils}/bin/rust-objcopy \
            "${keyberon-firmware-elf}/bin/stm32f4-onekey" \
            "--output-target" "binary" \
            "$out/bin/stm32f4-onekey.bin"
        '';

        keyberon-firmware-uf2 = pkgs.runCommand "" {} ''
          mkdir -p $out/bin

          ${uf2conv}/bin/uf2conv \
            --convert \
            --family=STM32F4 \
            --base 0x8010000 \
            --output=$out/bin/minif4-36-rev2021_1-lhs.uf2 \
            ${keyberon-firmware-bin}/bin/minif4-36-rev2021_1-lhs.bin

          ${uf2conv}/bin/uf2conv \
            --convert \
            --family=STM32F4 \
            --base 0x8010000 \
            --output=$out/bin/minif4-36-rev2021_1-rhs.uf2 \
            ${keyberon-firmware-bin}/bin/minif4-36-rev2021_1-rhs.bin

          ${uf2conv}/bin/uf2conv \
            --convert \
            --family=STM32F4 \
            --base 0x8010000 \
            --output=$out/bin/x_2-rev2021_1.uf2 \
            ${keyberon-firmware-bin}/bin/x_2-rev2021_1.bin

          ${uf2conv}/bin/uf2conv \
            --convert \
            --family=STM32F4 \
            --base 0x8010000 \
            --output=$out/bin/stm32f4-onekey.uf2 \
            ${keyberon-firmware-bin}/bin/stm32f4-onekey.bin
        '';
      };
    });
}
