{
  description = "Flake for development tooling for Keyboard labs.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachSystem [
      flake-utils.lib.system.x86_64-linux
    ] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      bootloaders = import ./scripts/bootloaders.nix {
        inherit pkgs;
      };
    in {
      packages = {
        bootloader-stm32f103-stm32duino = bootloaders.stm32f103.stm32duino;
        bootloader-stm32f401-tinyuf2 = bootloaders.stm32f401.tinyuf2;
        bootloader-stm32f411-tinyuf2 = bootloaders.stm32f411.tinyuf2;
        docker-kibot-kicad = import ./scripts/docker-kibot.nix {
          pkgs = pkgs;
          tag = "kicad-7";
        };
        kicad = pkgs.kicad;
      };
      devShells = {
        interactive-html-bom = import ./scripts/shell-interactive-html-bom.nix {
          pkgs = pkgs;
        };

        pcb = import ./pcb/shell.nix {
          pkgs = pkgs;
          on-nixos = false;
        };

        pcb-nixos = import ./pcb/shell.nix {
          pkgs = pkgs;
          on-nixos = true;
        };
      };
    });
}
