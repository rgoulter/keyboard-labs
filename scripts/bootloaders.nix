# Usage:
#   nix-build bootloaders.nix -A stm32f103.stm32duino
# then use the resulting firmware at path:
#   ./result/generic_boot20_pc13.bin

{ pkgs ? import <nixpkgs> {} }:

{
  stm32f103 = {
    stm32duino = pkgs.stdenv.mkDerivation rec {
      pname = "stm32duino";
      version = "df689808b6030280480c0d151ee9c552ecf6b405";

      # https://github.com/rogerclarkmelbourne/STM32duino-bootloader/commit/df689808b6030280480c0d151ee9c552ecf6b405
      src = pkgs.fetchgit {
        # owner = "rogerclarkmelbourne";
        # repo = pname;
        url = "https://github.com/rogerclarkmelbourne/STM32duino-bootloader";
        rev = version;
        sha256 = "1ilivbr8l7zninqsaisvryvda6kmblh04hdhc91lylqz682b1chb";
      };

      # The repo already checks in the binary,
      # so we don't need to build it.
      dontBuild = true;

      installPhase = ''
        mkdir -p $out/
        cp binaries/generic_boot20_pc13.bin $out
      '';
    };
  };
  stm32f401 = {
    tinyuf2 = pkgs.stdenv.mkDerivation rec {
      pname = "tinyuf2";
      version = "0.6.2";

      # tinyuf2 assumes compiled using git repo.
      # Takes about 7m to clone all the subrepos(!!).
      # But, if set fetchSubmodules = false, then
      #  the repo otherwise complains. and git doesn't recognise
      #  the submodule pathspec in the build phase.
      src = pkgs.fetchgit {
        url = "https://github.com/adafruit/tinyuf2";
        rev = version;
        sha256 = "0irgpf7zbbr22ji7hibcyz6hvw9l980sxir3xyim7k71l2rwpgxh";
      };

      buildInputs = with pkgs; [
        gcc-arm-embedded
        git
        gnumake
      ];

      buildPhase = ''
        ls -al
        cd ports/stm32f4
        make BOARD=stm32f401_blackpill all
      '';

      installPhase = ''
        mkdir -p $out/
        cp _build/stm32f401_blackpill/tinyuf2-stm32f401_blackpill* $out/
      '';
    };
  };
}
