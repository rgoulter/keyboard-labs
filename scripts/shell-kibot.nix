{ pkgs ? import <nixpkgs> {} }:

with pkgs;
let
  kibot = callPackage ./pkgs/kibot {};
  pcbdraw = callPackage ./pkgs/pcbdraw {};
  recordmydesktop = callPackage ./pkgs/recordmydesktop {};
in
mkShell {
  buildInputs = [
    kibot
    pcbdraw
    recordmydesktop
    xdotool
  ];
}
