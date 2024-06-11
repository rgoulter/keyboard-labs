{
  description = "Flake for development tooling for Keyboard labs.";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    naersk = {
      url = "github:nmattia/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For the offline ISO,
    # use same version of Nickel as Fak uses.
    nickel = {
      url = "github:tweag/nickel/1.2.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/x86_64-linux";
  };

  outputs = inputs @ {
    self,
    nickel,
    nixpkgs,
    flake-parts,
    nixos-generators,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;

      imports = [
        ./firmware/keyberon/flake-module.nix
      ];

      flake = {
        nixosModules = import ./nix/nixosModules;

        packages.x86_64-linux = let
          system = "x86_64-linux";
        in {
          gcc-arm-a-embedded = nixpkgs.legacyPackages.x86_64-linux.callPackage ./nix/pkgs/gcc-arm-a-embedded {};

          # An ISO for a live environment, with packages
          # for flashing fak firmware.
          offline-iso = nixos-generators.nixosGenerate {
            pkgs = import nixpkgs {
              inherit system;
              config = {allowUnfree = true;};
              overlays = [
                (final: prev: {
                  nickel = nickel.packages."x86_64-linux".default;
                  wchisp = self.packages.${system}.wchisp;
                })
              ];
            };
            format = "iso";
            modules = [
              self.nixosModules.offline-iso
            ];
          };
        };
      };

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        checks = {
          firmware = pkgs.symlinkJoin {
            name = "keyboard-labs-firmware";
            paths = [
              self.packages.${system}.bootloader-stm32f103-stm32duino
              self.packages.${system}.bootloader-stm32f401-tinyuf2
              self.packages.${system}.bootloader-stm32f411-tinyuf2
              self.packages.${system}.qmk-bm40hsrgb-rgoulter
              self.packages.${system}.qmk-minif4_36-rev2021_5-blackpill_f401-rgoulter
              self.packages.${system}.qmk-pico42-rgoulter-basic
              self.packages.${system}.qmk-pico42-manna-harbour_miryoku
              self.packages.${system}.qmk-pico42-vial
              self.packages.${system}.qmk-pykey40-lite-rgoulter
              self.packages.${system}.qmk-pykey40-lite-rgoulter-pinkieoutercolumn
              self.packages.${system}.qmk-pykey40-lite-vial
              self.packages.${system}.qmk-x_2-rev2021_1-bluepill
              self.packages.${system}.qmk-x_2-rev2021_1-blackpill_f401
            ];
          };

          pcb = pkgs.symlinkJoin {
            name = "keyboard-labs-pcb";
            paths = [
              self.packages.${system}.pcb-keyboard-100x100-minif4-dual-rgb-reversible
              self.packages.${system}.pcb-keyboard-ch552-36-lhs
              self.packages.${system}.pcb-keyboard-ch552-36-rhs
              self.packages.${system}.pcb-keyboard-ch552-44
              self.packages.${system}.pcb-keyboard-ch552-48
              self.packages.${system}.pcb-keyboard-ch552-48-lpr
              self.packages.${system}.pcb-keyboard-pico42
              self.packages.${system}.pcb-keyboard-pykey40-hsrgb
              self.packages.${system}.pcb-keyboard-pykey40-lite
              self.packages.${system}.pcb-keyboard-x2-lumberjack-arm-hsrgb
              self.packages.${system}.pcb-keyboard-x2-lumberjack-arm
            ];
          };
        };

        devShells = {
          pcb = import ./pcb/shell.nix {
            pkgs = pkgs;
            on-nixos = false;
          };

          pcb-nixos = import ./pcb/shell.nix {
            pkgs = pkgs;
            on-nixos = true;
          };
        };

        packages = let
          bootloaders = import ./nix/pkgs/bootloaders {
            inherit pkgs;
          };
          qmk = pkgs.callPackage ./nix/pkgs/qmk {};
          pcb = pkgs.callPackage ./pcb {};
        in {
          bootloader-stm32f103-stm32duino = bootloaders.stm32duino.stm32f103;
          bootloader-stm32f401-tinyuf2 = bootloaders.tinyuf2.stm32f401;
          bootloader-stm32f411-tinyuf2 = bootloaders.tinyuf2.stm32f411;
          qmk-bm40hsrgb-rgoulter = qmk.bm40hsrgb-rgoulter;
          qmk-minif4_36-rev2021_5-blackpill_f401-rgoulter = qmk.minif4_36-rev2021_5-blackpill_f401-rgoulter;
          qmk-pico42-rgoulter-basic = qmk.pico42-rgoulter-basic;
          qmk-pico42-manna-harbour_miryoku = qmk.pico42-manna-harbour_miryoku;
          qmk-pico42-vial = qmk.pico42-vial;
          qmk-pykey40-lite-rgoulter = qmk.pykey40-lite-rgoulter;
          qmk-pykey40-lite-rgoulter-pinkieoutercolumn = qmk.pykey40-lite-rgoulter-pinkieoutercolumn;
          qmk-pykey40-lite-vial = qmk.pykey40-lite-vial;
          qmk-x_2-rev2021_1-bluepill = qmk.x_2-rev2021_1-bluepill;
          qmk-x_2-rev2021_1-blackpill_f401 = qmk.x_2-rev2021_1-blackpill_f401;

          pcb-keyboard-100x100-minif4-dual-rgb-reversible = pcb.keyboard-100x100-minif4-dual-rgb-reversible;
          pcb-keyboard-ch552-36-lhs = pcb.keyboard-ch552-36-lhs;
          pcb-keyboard-ch552-36-rhs = pcb.keyboard-ch552-36-rhs;
          pcb-keyboard-ch552-44 = pcb.keyboard-ch552-44;
          pcb-keyboard-ch552-48 = pcb.keyboard-ch552-48;
          pcb-keyboard-ch552-48-lpr = pcb.keyboard-ch552-48-lpr;
          pcb-keyboard-pico42 = pcb.keyboard-pico42;
          pcb-keyboard-pykey40-hsrgb = pcb.keyboard-pykey40-hsrgb;
          pcb-keyboard-pykey40-lite = pcb.keyboard-pykey40-lite;
          pcb-keyboard-x2-lumberjack-arm-hsrgb = pcb.keyboard-x2-lumberjack-arm-hsrgb;
          pcb-keyboard-x2-lumberjack-arm = pcb.keyboard-x2-lumberjack-arm;

          uf2conv = pkgs.callPackage ./nix/pkgs/uf2conv {};
          wchisp = pkgs.callPackage ./nix/pkgs/wchisp {};

          docker-kibot-kicad = import ./scripts/docker-kibot.nix {
            pkgs = pkgs;
            tag = "kicad-7";
          };
        };
      };
    };
}
