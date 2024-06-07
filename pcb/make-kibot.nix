# Nix package recipe for `make <board>-kibot` targets.
{
  board,
  board_version ? "1.0",
  ibom ? false,
  stdenvNoCC,
  lib,
  kicad,
  interactive-html-bom,
  kibot,
  pcbdraw,
  recordmydesktop,
  fluxbox,
  turbovnc,
  virtualgl,
  wmctrl,
  x11vnc,
  xclip,
  xdotool,
  xorg,
}:

stdenvNoCC.mkDerivation rec {
  pname = "${board}-kibot";
  version = board_version;

  KICAD_SYMBOL_DIR = "${kicad.libraries.symbols}/share/kicad/library";
  KISYS3DMOD = "${kicad.libraries.packages3d}/share/kicad/modules/packages3d";
  KISYSMOD = "${kicad.libraries.footprints}/share/kicad/modules";

  KIAUTO_INTERPOSER_DISABLE = "1";

  src = ./.;

  buildInputs = [
    fluxbox
    interactive-html-bom
    kibot
    pcbdraw
    recordmydesktop
    turbovnc
    virtualgl
    wmctrl
    x11vnc
    xclip
    xdotool
    xorg.xkbcomp
  ];

  buildPhase = ''
    runHook preBuild

    export KICAD_CONFIG_HOME=$(mktemp -d)
    make ${board}-kibot
  '' + (lib.optionalString ibom ''
    make ${board}-ibom
  '') + ''
    runHook postBuild
  '';

  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/docs
    cp -r docs/* $out/docs

    mkdir -p $out/gerbers
    cp -r gerbers/* $out/gerbers
  '' + (lib.optionalString ibom ''
    mkdir -p $out/bom
    cp -r bom/* $out/bom
  '') + ''
    runHook postInstall
  '';
}
