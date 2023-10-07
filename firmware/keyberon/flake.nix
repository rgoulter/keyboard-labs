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
        RUSTC="${toolchain}/bin/rustc";
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

          env PATH=$PATH:${pkgs.cargo-binutils}/bin \
            ${pkgs.gnumake}/bin/make \
              --file ${./Makefile} \
              RELEASE_TARGET_DIR=${keyberon-firmware-elf}/bin \
              DEST_DIR=$out/bin \
              $out/bin/minif4-36-rev2021_1-lhs.bin \
              $out/bin/minif4-36-rev2021_1-rhs.bin \
              $out/bin/x_2-rev2021_1.bin \
              $out/bin/stm32f4-onekey.bin
        '';

        keyberon-firmware-uf2 = pkgs.runCommand "" {} ''
          mkdir -p $out/bin

          cp ${keyberon-firmware-bin}/bin/*.bin $out/bin

          env PATH=$PATH:${uf2conv}/bin \
            ${pkgs.gnumake}/bin/make \
              --file ${./Makefile} \
              RELEASE_TARGET_DIR=${keyberon-firmware-elf}/bin \
              DEST_DIR=$out/bin \
              $out/bin/minif4-36-rev2021_1-lhs.uf2 \
              $out/bin/minif4-36-rev2021_1-rhs.uf2 \
              $out/bin/x_2-rev2021_1.uf2 \
              $out/bin/stm32f4-onekey.uf2

          rm $out/bin/*.bin
        '';
      };
    });
}
