# Usage:
#   nix-build default.nix -A stm32f103
# then use the resulting firmware at path:
#   ./result/generic_boot20_pc13.bin
{pkgs ? import <nixpkgs> {}}: {
  stm32f103 = pkgs.stdenv.mkDerivation rec {
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
}
