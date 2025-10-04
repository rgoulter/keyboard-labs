{
  description = "Flake for development tooling for Keyboard labs.";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    devenv-root,
    devenv,
    nickel,
    nixpkgs,
    flake-parts,
    nixos-generators,
    systems,
    treefmt-nix,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;

      imports = [
        devenv.flakeModule
        ./firmware/keyberon/flake-module.nix
      ];

      flake = {
        nixosModules = import ./nix/nixosModules;

        packages.x86_64-linux = let
          system = "x86_64-linux";
        in {
          gcc-arm-a-embedded = nixpkgs.legacyPackages.x86_64-linux.callPackage ./nix/pkgs/gcc-arm-a-embedded {};
        };
      };

      perSystem = {
        config,
        lib,
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
            ];
          };

        };

        devenv.shells.default = {pkgs, ...}: {
          devenv.root = let
            devenvRootFileContent = builtins.readFile devenv-root.outPath;
          in
            pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;

          # https://github.com/cachix/devenv/issues/528
          containers = pkgs.lib.mkForce {};

          programs.treefmt.package = config.treefmt.build.wrapper;

          imports = [./devenv.nix];
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
          qmk =
            lib.attrsets.mapAttrs' (name: p: lib.attrsets.nameValuePair "qmk-${name}" p)
            (lib.attrsets.filterAttrs (_: p: lib.attrsets.isDerivation p) (pkgs.callPackage ./nix/pkgs/qmk {}));
          pcb =
            lib.attrsets.mapAttrs' (name: p: lib.attrsets.nameValuePair "pcb-${name}" p)
            (lib.attrsets.filterAttrs (_: p: lib.attrsets.isDerivation p) (pkgs.callPackage ./pcb {}));
        in
          {
            bootloader-stm32f103-stm32duino = bootloaders.stm32duino.stm32f103;
            bootloader-stm32f401-tinyuf2 = bootloaders.tinyuf2.stm32f401;
            bootloader-stm32f411-tinyuf2 = bootloaders.tinyuf2.stm32f411;

            uf2conv = pkgs.callPackage ./nix/pkgs/uf2conv {};
            wchisp = pkgs.callPackage ./nix/pkgs/wchisp {};

            docker-kibot-kicad = import ./scripts/docker-kibot.nix {
              pkgs = pkgs;
              tag = "kicad-7";
            };
          }
          // pcb
          // qmk;
      };
    };
}
