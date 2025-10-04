{python3Packages}:
with python3Packages;
  buildPythonPackage rec {
    pname = "mistune";
    version = "2.0.5";

    pyproject = true;
    build-system = [python3Packages.setuptools];

    propagatedBuildInputs = [
    ];

    doCheck = false;

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-AkYRPLJJLbh1xr5Wl0p8iTMzvybNkokchfYxUc7gnTQ=";
    };
  }
