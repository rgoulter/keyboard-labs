{python3Packages}:
with python3Packages;
  buildPythonPackage rec {
    pname = "svgpathtools";
    version = "1.4.1";

    pyproject = true;
    build-system = [python3Packages.setuptools];

    propagatedBuildInputs = [
      numpy
      scipy
      svgwrite
    ];

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-equgeSOthbZigwHpLl5y/Q0KUFdiDhQjUJs6C2CbdIU=";
    };
  }
