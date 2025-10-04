{
  lib,
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
  python3Packages.buildPythonPackage rec {
    pname = "kiauto";
    version = "2.3.5";

    pyproject = true;
    build-system = [python3Packages.setuptools];

    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-WfN4OnAi8t0RlC5couVdamRQ76YielDrAS2WDregstI=";
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
  }
