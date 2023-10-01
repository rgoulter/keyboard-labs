{
  lib,
  qmk,
  stdenv,
  fetchFromGitHub,
}: let
  compile = import ./compile.nix {inherit lib qmk stdenv fetchFromGitHub;};
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
  pico42-rgoulter-basic = compile {
    keyboard = "rgoulter/pico42";
    keymap = "rgoulter-basic";
  };
  pykey40-rgoulter = compile {
    keyboard = "rgoulter/pykey40";
    keymap = "rgoulter";
  };
  pykey40-rgoulter-pinkieoutercolumn = compile {
    keyboard = "rgoulter/pykey40";
    keymap = "rgoulter-pinkieoutercolumn";
  };
  x_2-rev2021_1-bluepill = compile {
    keyboard = "rgoulter/x_2/rev2021_1/bluepill";
    keymap = "rgoulter";
    output_extension = "bin";
  };
}
