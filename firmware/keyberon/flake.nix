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
      toolchain = with fenix.packages.${system};
        combine [
          complete.llvm-tools-preview
          complete.rust-src
          default.rustfmt
          default.cargo
          default.rustc
          targets."thumbv6m-none-eabi".latest.rust-std
          targets."thumbv7em-none-eabihf".latest.rust-std
        ];
    in let
      uf2conv = pkgs.callPackage ../../nix/pkgs/uf2conv {};
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.cargo-binutils
          pkgs.elf2uf2-rs
          pkgs.hidrd
          pkgs.just
          pkgs.rust-analyzer
          pkgs.usbutils
          pkgs.probe-rs
          pkgs.stlink
          toolchain
          uf2conv
        ];
        RUSTC = "${toolchain}/bin/rustc";
        RUST_SRC_PATH = "${toolchain}/lib/rustlib/src";
      };

      packages = let
        rp2040-bins = [
          "blinky"
        ];
        stm32f4-bins = [
          "minif4-36-rev2021_4-lhs"
          "minif4-36-rev2021_4-rhs"
          "minif4-36-rev2021_5-lhs"
          "minif4-36-rev2021_5-rhs"
          "x_2-rev2021_1"
          "weact-minif4-onekey"
        ];
        in rec {
        keyberon-firmware-rp2040-elf =
          let
            target = "thumbv6m-none-eabi";
          in
          (naersk.lib.${system}.override {
            cargo = toolchain;
            rustc = toolchain;
          })
          .buildPackage {
            src = ./.;
            overrideMain = x: {
              preConfigure = ''
                cargo_build_options="$cargo_build_options --package=keyboard-labs-keyberon-rp2040"
              '';
            };
            CARGO_BUILD_TARGET = target;
            CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER = "${pkgs.pkgsCross.aarch64-multiplatform.stdenv.cc}/bin/${target}-gcc";
          };

        keyberon-firmware-stm32f4-elf =
          let
            target = "thumbv7em-none-eabihf";
          in
          (naersk.lib.${system}.override {
            cargo = toolchain;
            rustc = toolchain;
          })
          .buildPackage {
            src = ./.;
            overrideMain = x: {
              preConfigure = ''
                cargo_build_options="$cargo_build_options --package=keyboard-labs-keyberon-stm32f4"
              '';
            };
            CARGO_BUILD_TARGET = target;
            CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER = "${pkgs.pkgsCross.aarch64-multiplatform.stdenv.cc}/bin/${target}-gcc";
          };

        keyberon-firmware-bin = pkgs.runCommand "keyboard-labs-keyberon-firmware-bin" {} ''
          mkdir -p $out/bin
          export RUSTC=${toolchain}/bin/rustc

          env PATH=$PATH:${pkgs.cargo-binutils}/bin \
            ${pkgs.gnumake}/bin/make \
              --file ${./Makefile} \
              RP2040_RELEASE_TARGET_DIR=${keyberon-firmware-rp2040-elf}/bin \
              STM32F4_RELEASE_TARGET_DIR=${keyberon-firmware-stm32f4-elf}/bin \
              DEST_DIR=$out/bin \
              ${nixpkgs.lib.concatStringsSep " " (map (x: "$out/bin/${x}.bin") rp2040-bins)} \
              ${nixpkgs.lib.concatStringsSep " " (map (x: "$out/bin/${x}.bin") stm32f4-bins)}
        '';

        keyberon-firmware-uf2 = pkgs.runCommand "" {} ''
          mkdir -p $out/bin

          cp ${keyberon-firmware-bin}/bin/*.bin $out/bin

          env PATH=$PATH:${uf2conv}/bin \
            ${pkgs.gnumake}/bin/make \
              --file ${./Makefile} \
              RP2040_RELEASE_TARGET_DIR=${keyberon-firmware-rp2040-elf}/bin \
              STM32F4_RELEASE_TARGET_DIR=${keyberon-firmware-stm32f4-elf}/bin \
              DEST_DIR=$out/bin \
              ${nixpkgs.lib.concatStringsSep " " (map (x: "$out/bin/${x}.uf2") rp2040-bins)} \
              ${nixpkgs.lib.concatStringsSep " " (map (x: "$out/bin/${x}.uf2") stm32f4-bins)}

          rm $out/bin/*.bin
        '';
      };
    });
}
