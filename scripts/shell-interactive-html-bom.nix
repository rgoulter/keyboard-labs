{pkgs ? import <nixpkgs> {}}:
with pkgs; let
  interactive-html-bom = callPackage ./pkgs/interactive-html-bom {};
in
  mkShell {
    buildInputs = [
      interactive-html-bom
    ];
  }
