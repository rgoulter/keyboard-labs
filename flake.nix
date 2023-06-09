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
      bootloaders = import ./nix/pkgs/bootloaders {
        inherit pkgs;
      };
    in {
      packages = {
        bootloader-stm32f103-stm32duino = bootloaders.stm32duino.stm32f103;
        bootloader-stm32f401-tinyuf2 = bootloaders.tinyuf2.stm32f401;
        bootloader-stm32f411-tinyuf2 = bootloaders.tinyuf2.stm32f411;
        docker-kibot-kicad = import ./scripts/docker-kibot.nix {
          pkgs = pkgs;
          tag = "kicad-7";
        };
        kicad = pkgs.kicad;
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
    });
}
