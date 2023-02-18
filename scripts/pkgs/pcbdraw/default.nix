{
  lib,
  fetchFromGitHub,
  python3Packages,
  python3,
  kicad,
}: let
  kicadPythonModule =
    python3Packages.toPythonModule
    (kicad.override {
      inherit python3;
    })
    .src;
in
  with python3Packages; let
    pcbnewTransition = buildPythonPackage rec {
      pname = "pcbnewTransition";
      version = "0.2.0";

      propagatedBuildInputs = [
        kicadPythonModule
        versioneer
      ];

      src = fetchPypi {
        inherit pname version;
        sha256 = "1dbw1h3pgc84garazmqxp25jgr5cnlvwjph26yi0223gmkkj0xfb";
      };
    };
    PyMeta3 = buildPythonPackage rec {
      pname = "PyMeta3";
      version = "0.5.1";

      propagatedBuildInputs = [
        twisted
      ];

      doCheck = false;

      src = fetchPypi {
        inherit pname version;
        sha256 = "1jsvs20qdnflap7qna37n1w4v5k4d34hpvn0py3zbfx9v4ka7g8q";
      };
    };
    pybars3 = buildPythonPackage rec {
      pname = "pybars3";
      version = "0.9.7";

      propagatedBuildInputs = [
        PyMeta3
      ];

      doCheck = false;

      src = fetchPypi {
        inherit pname version;
        sha256 = "0lp2q0gazy8nii9g8ybzfszjfpj7234i5wbajddrqfz50pllgj3a";
      };
    };
    svgpathtools = buildPythonPackage rec {
      pname = "svgpathtools";
      version = "1.4.1";

      propagatedBuildInputs = [
        numpy
        scipy
        svgwrite
      ];

      src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-equgeSOthbZigwHpLl5y/Q0KUFdiDhQjUJs6C2CbdIU=";
      };
    };
  in
    buildPythonApplication rec {
      pname = "pcbdraw";
      version = "1.0.1";

      # fails on Windows-specific test
      doCheck = false;

      propagatedBuildInputs = [
        click
        lxml
        mistune
        numpy
        pcbnewTransition
        pillow
        pybars3
        pyyaml
        svgpathtools
        Wand
        wxPython_4_1
        virtual-display
      ];

      patches = [./allow-polygon-board-outlines.patch];

      # INTI-CMNB (GitHub owner of KiBot) also maintains a fork
      # https://github.com/INTI-CMNB/PcbDraw
      src = fetchFromGitHub {
        owner = "yaqwsx";
        repo = "PcbDraw";
        rev = "v${version}";
        sha256 = "sha256-zEYnMJ6CcdYUzetw3xFtcpWRD5lZvcxcxnMIs69rbnA=";
        # sha256 = "sha256-S0lOzwkrCBFopVSEP8lJwtwI27TRt2CcR6SMbqNiwIQ=";
        # sha256 = lib.fakeSha256;
      };
    }
