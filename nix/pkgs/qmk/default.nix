{
  lib,
  qmk,
  rsync,
  stdenv,
  fetchFromGitHub,
}: let
  compile = import ./compile.nix {inherit lib qmk stdenv fetchFromGitHub;};
  compile-vial = import ./vial.nix {inherit lib rsync qmk stdenv fetchFromGitHub;};
in {
  bm40hsrgb-rgoulter = compile {
    keyboard = "kprepublic/bm40hsrgb";
    keymap = "rgoulter";
    output_extension = "hex";
  };
  minif4_36-rev2021_5-blackpill_f401-rgoulter = compile {
    keyboard = "rgoulter/minif4_36/rev2021_5/blackpill_f401";
    keymap = "rgoulter";
  };
  pico42-manna-harbour_miryoku = compile {
    keyboard = "rgoulter/pico42";
    keymap = "manna-harbour_miryoku";
    env = [
      "FORCE_LAYOUT=split_3x5_3"
    ];
  };
  pico42-rgoulter-basic = compile {
    keyboard = "rgoulter/pico42";
    keymap = "rgoulter-basic";
  };
  pico42-vial = compile-vial {
    keyboard = "rgoulter/pico42";
    keymap = "vial";
  };
  pykey40-lite-rgoulter = compile {
    keyboard = "rgoulter/pykey40/lite";
    keymap = "rgoulter";
  };
  pykey40-lite-rgoulter-pinkieoutercolumn = compile {
    keyboard = "rgoulter/pykey40/lite";
    keymap = "rgoulter-pinkieoutercolumn";
  };
  pykey40-lite-vial = compile-vial {
    keyboard = "rgoulter/pykey40/lite";
    keymap = "vial";
  };
  x_2-rev2021_1-bluepill = compile {
    keyboard = "rgoulter/x_2/rev2021_1/bluepill";
    keymap = "rgoulter";
    output_extension = "bin";
  };
}
