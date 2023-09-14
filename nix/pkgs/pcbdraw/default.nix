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
    version = "1.1.2";

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
      rev = "v${version}";
      sha256 = "sha256-zMk5fZCDIu+XBwGcJ6NEFvyTUHA8pRtkLaZebW63t5A=";
    };
  }
