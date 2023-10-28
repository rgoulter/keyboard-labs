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
      qmk = pkgs.callPackage ./nix/pkgs/qmk {};
    in {
      packages = {
        bootloader-circuitpython-jpconstantineau_pykey60 = bootloaders.circuitpython.jpconstantineau_pykey60;
        bootloader-stm32f103-stm32duino = bootloaders.stm32duino.stm32f103;
        bootloader-stm32f401-tinyuf2 = bootloaders.tinyuf2.stm32f401;
        bootloader-stm32f411-tinyuf2 = bootloaders.tinyuf2.stm32f411;
        qmk-bm40hsrgb-rgoulter = qmk.bm40hsrgb-rgoulter;
        qmk-minif4_36-rev2021_5-blackpill_f401-rgoulter = qmk.minif4_36-rev2021_5-blackpill_f401-rgoulter;
        qmk-pico42-rgoulter-basic = qmk.pico42-rgoulter-basic;
        qmk-pico42-manna-harbour_miryoku = qmk.pico42-manna-harbour_miryoku;
        qmk-pico42-vial = qmk.pico42-vial;
        qmk-pykey40-rgoulter = qmk.pykey40-rgoulter;
        qmk-pykey40-rgoulter-pinkieoutercolumn = qmk.pykey40-rgoulter-pinkieoutercolumn;
        qmk-pykey40-vial = qmk.pykey40-vial;
        qmk-x_2-rev2021_1-bluepill = qmk.x_2-rev2021_1-bluepill;

        uf2conv = pkgs.callPackage ./nix/pkgs/uf2conv {};

        docker-kibot-kicad = import ./scripts/docker-kibot.nix {
          pkgs = pkgs;
          tag = "kicad-7";
        };
        gcc-arm-a-embedded = pkgs.callPackage ./nix/pkgs/gcc-arm-a-embedded {};
        kicad = pkgs.kicad;
      };
      devShells = {
        circuitpython = import ./nix/shells/circuitpython/shell.nix {
          inherit pkgs;
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
