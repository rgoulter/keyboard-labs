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
        minif4-36-2021_1 = (naersk.lib.${system}.override {
          cargo = toolchain;
          rustc = toolchain;
        }).buildPackage {
          src = ./.;
          CARGO_BUILD_TARGET = target;
          CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER =
            "${pkgs.pkgsCross.aarch64-multiplatform.stdenv.cc}/bin/${target}-gcc";
        };

        minif4-36-2021_1-firmware = pkgs.runCommand "minif4-36-2021_1-firmware" {} ''
          mkdir -p $out/bin
          export RUSTC=${toolchain}/bin/rustc

          ${pkgs.cargo-binutils}/bin/rust-objcopy \
            "${minif4-36-2021_1}/bin/minif4-36-rev2021_1-lhs" \
            "--output-target" "binary" \
            "$out/bin/minif4-36-rev2021_1-lhs.bin"

          ${pkgs.cargo-binutils}/bin/rust-objcopy \
            "${minif4-36-2021_1}/bin/minif4-36-rev2021_1-rhs" \
            "--output-target" "binary" \
            "$out/bin/minif4-36-rev2021_1-rhs.bin"
        '';
      };
    });
}
