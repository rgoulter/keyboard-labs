{
  lib,
  fetchFromGitHub,
  python3Packages,
  python3,
  kicad,
  pcbnewTransition ? import ../pythonPackages/pcbnewTransition {inherit kicad python3 python3Packages;},
  pybars3 ? import ../pythonPackages/pybars3 {inherit python3Packages;},
  svgpathtools ? import ../pythonPackages/svgpathtools {inherit python3Packages;},
}:
with python3Packages;
  buildPythonApplication rec {
    pname = "pcbdraw";
    version = "1.1.3-pre";

    # fails on Windows-specific test
    doCheck = false;

    propagatedBuildInputs = [
      click
      lxml
      mistune
      numpy
      PyVirtualDisplay
      pcbnewTransition
      pillow
      pybars3
      pyyaml
      svgpathtools
      Wand
      wxPython_4_2
    ];

    patches = [./allow-polygon-board-outlines.patch];

    # INTI-CMNB (GitHub owner of KiBot) also maintains a fork
    # https://github.com/INTI-CMNB/PcbDraw
    src = fetchFromGitHub {
      owner = "yaqwsx";
      repo = "PcbDraw";
      rev = "1264f28eb0cb96ab7ec44ecb09c5d50eef508ec5";
      hash = "sha256-SrKILQ/CsNK+juV47iIHBz/4Htja4oykQXFGmJ7P/L0=";
    };
  }
