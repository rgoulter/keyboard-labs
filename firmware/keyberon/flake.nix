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
          minimal.rustc
          minimal.cargo
          complete.llvm-tools-preview
          targets.${target}.latest.rust-std
        ];
    in
    {
      packages = rec {
        minif4-2021_1-lhs = (naersk.lib.${system}.override {
          cargo = toolchain;
          rustc = toolchain;
        }).buildPackage {
          src = ./.;
          targets = ["keyberon-f4-split-dp"];
          MINIF4_36_REVISION="2021.1";
          CARGO_BUILD_TARGET = target;
          CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER =
            "${pkgs.pkgsCross.aarch64-multiplatform.stdenv.cc}/bin/${target}-gcc";
        };

        minif4-2021_1-rhs = (naersk.lib.${system}.override {
          cargo = toolchain;
          rustc = toolchain;
        }).buildPackage {
          src = ./.;
          targets = ["keyberon-f4-split-dp"];
          cargoBuildOptions =
            opts: opts ++ ["--features" "split-right" "--no-default-features"];
          MINIF4_36_REVISION="2021.1";
          CARGO_BUILD_TARGET = target;
          CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER =
            "${pkgs.pkgsCross.aarch64-multiplatform.stdenv.cc}/bin/${target}-gcc";
        };

        minif4-2021_1-firmware = pkgs.runCommand "minif4-2021_1-lhs-fw" {} ''
          mkdir -p $out/bin
          export RUSTC=${toolchain}/bin/rustc

          ${pkgs.cargo-binutils}/bin/rust-objcopy \
            "${minif4-2021_1-lhs}/bin/keyberon-f4-split-dp" \
            "--output-target" "binary" \
            "$out/bin/keyberon-left.bin"

          ${pkgs.cargo-binutils}/bin/rust-objcopy \
            "${minif4-2021_1-rhs}/bin/keyberon-f4-split-dp" \
            "--output-target" "binary" \
            "$out/bin/keyberon-right.bin"
        '';
      };
    });
}
