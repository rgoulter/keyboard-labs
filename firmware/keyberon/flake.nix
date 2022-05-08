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

  outputs = { self, fenix, flake-utils, naersk, nixpkgs }:
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
    in
    {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.rust-analyzer
          toolchain
        ];
        RUST_SRC_PATH="${toolchain}/lib/rustlib/src";
      };

      packages = rec {
        keyberon-firmware = (naersk.lib.${system}.override {
          cargo = toolchain;
          rustc = toolchain;
        }).buildPackage {
          src = ./.;
          CARGO_BUILD_TARGET = target;
          CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER =
            "${pkgs.pkgsCross.aarch64-multiplatform.stdenv.cc}/bin/${target}-gcc";
          # Use memory.x for STM32F4xx for running on tinyuf2
          CARGO_TARGET_THUMBV7EM_NONE_EABIHF_RUSTFLAGS =
            "-C link-arg=--library-path=ld/stm32f4xx-tinyuf2";
        };

        keyberon-firmware-bin = pkgs.runCommand "keyboard-labs-keyberon-firmware-bin" {} ''
          mkdir -p $out/bin
          export RUSTC=${toolchain}/bin/rustc

          ${pkgs.cargo-binutils}/bin/rust-objcopy \
            "${keyberon-firmware}/bin/minif4-36-rev2021_1-lhs" \
            "--output-target" "binary" \
            "$out/bin/minif4-36-rev2021_1-lhs.bin"

          ${pkgs.cargo-binutils}/bin/rust-objcopy \
            "${keyberon-firmware}/bin/minif4-36-rev2021_1-rhs" \
            "--output-target" "binary" \
            "$out/bin/minif4-36-rev2021_1-rhs.bin"

          ${pkgs.cargo-binutils}/bin/rust-objcopy \
            "${keyberon-firmware}/bin/x_2-rev2021_1" \
            "--output-target" "binary" \
            "$out/bin/x_2-rev2021_1.bin"
        '';
      };
    });
}
