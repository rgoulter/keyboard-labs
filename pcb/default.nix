{
  pkgs ? import <nixpkgs> {},
  interactive-html-bom ? pkgs.callPackage ../nix/pkgs/interactive-html-bom {},
  kibot ? pkgs.callPackage ../nix/pkgs/kibot {},
  pcbdraw ? pkgs.callPackage ../nix/pkgs/pcbdraw {},
  recordmydesktop ? pkgs.callPackage ../nix/pkgs/recordmydesktop {},
}: let
  callPackage = pkgs.lib.callPackageWith (pkgs
    // {
      inherit interactive-html-bom kibot pcbdraw recordmydesktop;
    });
in {
  keyboard-100x100-minif4-dual-rgb-reversible = callPackage ./make-kibot.nix {
    board = "keyboard-100x100-minif4-dual-rgb-reversible";
  };
  keyboard-ch552-36-lhs = callPackage ./make-kibot.nix {
    board = "keyboard-ch552-36-lhs";
  };
  keyboard-ch552-36-rhs = callPackage ./make-kibot.nix {
    board = "keyboard-ch552-36-rhs";
  };
  keyboard-ch552-44 = callPackage ./make-kibot.nix {
    board = "keyboard-ch552-44";
  };
  keyboard-ch552-48 = callPackage ./make-kibot.nix {
    board = "keyboard-ch552-48";
  };
  keyboard-ch552-48-lpr = callPackage ./make-kibot.nix {
    board = "keyboard-ch552-48-lpr";
  };
  keyboard-pico42 = callPackage ./make-kibot.nix {
    board = "keyboard-pico42";
  };
  keyboard-pykey40-hsrgb = callPackage ./make-kibot.nix {
    board = "keyboard-pykey40-hsrgb";
  };
  keyboard-pykey40-lite = callPackage ./make-kibot.nix {
    board = "keyboard-pykey40-lite";
  };
  keyboard-x2-lumberjack-arm-hsrgb = callPackage ./make-kibot.nix {
    board = "keyboard-x2-lumberjack-arm-hsrgb";
  };
  keyboard-x2-lumberjack-arm = callPackage ./make-kibot.nix {
    board = "keyboard-x2-lumberjack-arm";
  };
}
