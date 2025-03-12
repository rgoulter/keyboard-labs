{pkgs ? import <nixpkgs> {}}: {
  stm32f401 = pkgs.stdenv.mkDerivation rec {
    pname = "tinyuf2";
    version = "0.9.0";

    # tinyuf2 assumes compiled using git repo.
    # Takes about 7m to clone all the subrepos(!!).
    # But, if set fetchSubmodules = false, then
    #  the repo otherwise complains. and git doesn't recognise
    #  the submodule pathspec in the build phase.
    src = pkgs.fetchgit {
      url = "https://github.com/adafruit/tinyuf2";
      rev = version;
      sha256 = "sha256-NjGFlMOOawL581zmbR7TT/CCHpFgKISPMF58HAFaQrI=";
    };

    buildInputs = with pkgs; [
      gcc-arm-embedded
      git
      gnumake
    ];

    buildPhase = ''
      cd ports/stm32f4
      make BOARD=stm32f401_blackpill all
    '';

    installPhase = ''
      mkdir -p $out/
      cp _build/stm32f401_blackpill/tinyuf2-stm32f401_blackpill* $out/
    '';
  };
  stm32f411 = pkgs.stdenv.mkDerivation rec {
    pname = "tinyuf2";
    version = "0.9.0";

    # tinyuf2 assumes compiled using git repo.
    # Takes about 7m to clone all the subrepos(!!).
    # But, if set fetchSubmodules = false, then
    #  the repo otherwise complains. and git doesn't recognise
    #  the submodule pathspec in the build phase.
    src = pkgs.fetchgit {
      url = "https://github.com/adafruit/tinyuf2";
      rev = version;
      sha256 = "sha256-NjGFlMOOawL581zmbR7TT/CCHpFgKISPMF58HAFaQrI=";
    };

    buildInputs = with pkgs; [
      gcc-arm-embedded
      git
      gnumake
    ];

    buildPhase = ''
      cd ports/stm32f4
      make BOARD=stm32f411ce_blackpill V=1 all
      echo "after make"
    '';

    installPhase = ''
      mkdir -p $out/
      cp _build/stm32f411ce_blackpill/tinyuf2-stm32f411ce_blackpill* $out/
    '';
  };
}
