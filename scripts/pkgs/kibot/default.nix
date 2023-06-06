{
  lib,
  fetchFromGitHub,
  python3Packages,
  use-vglrun ? false,
  python3,
  kicad,
}: let
  kicadPythonModule =
    python3Packages.toPythonModule
    (kicad.override {
      inherit python3;
    })
    .src;
  kiauto = python3Packages.buildPythonPackage rec {
    pname = "kiauto";
    version = "2.2.5";

    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-3HhsHsG32WK6JjhdIFybfoLezeSMPpdeuSK0AKDtz9M";
    };

    propagatedBuildInputs = with python3Packages; [
      kicadPythonModule
      psutil
      xvfbwrapper
    ];

    meta = with lib; {
      homepage = "https://github.com/INTI-CMNB/KiAuto/";
      description = "A bunch of scripts to automate KiCad processes ";
      license = licenses.asl20;
      maintainers = with maintainers; [];
    };

    # Kludge:
    # On NixOS desktop, in order to run Kicad within Xvfb
    # I used VirtualGL's `vglrun`.
    # patches =
    #   lib.optional use-vglrun ./kiauto-pcbnew_do-cmd-vglrun-display1.patch;
  };
  qrcodegen = python3Packages.buildPythonPackage rec {
    pname = "qrcodegen";
    version = "1.7.0";

    src = fetchFromGitHub {
      owner = "nayuki";
      repo = "QR-Code-generator";
      rev = "v${version}";
      sha256 = "sha256-WH6O3YE/+NNznzl52TXZYL+6O25GmKSnaFqDDhRl4As=";
    };

    preBuild = ''
      cd python/
    '';

    propagatedBuildInputs = with python3Packages; [
    ];

    meta = with lib; {
      homepage = "https://www.nayuki.io/page/qr-code-generator-library";
      description = "High quality QR Code generator library for Python";
      license = licenses.mit;
      maintainers = with maintainers; [];
    };
  };
in
  python3Packages.buildPythonApplication rec {
    pname = "kibot";
    version = "1.5.1";

    patches = [./kibot-pcbdraw-allow-polygon-board-outlines.patch];

    # The macros module requires the module isn't compiled.
    # cf. https://github.com/INTI-CMNB/KiBot/issues/31
    postFixup = ''
      find $out -name '__pycache__' | xargs rm -rf
    '';

    propagatedBuildInputs = with python3Packages; [
      colorama
      kiauto
      kicadPythonModule
      markdown2
      pyyaml
      qrcodegen
      requests
      XlsxWriter
    ];

    doCheck = false;

    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-SzwHUmXYsWBw7pMEtkeFGILKRBwTlErMqsKihtNh6ig=";
    };
  }
