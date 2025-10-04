{
  python3Packages,
  PyMeta3 ? import ../pymeta3 {inherit python3Packages;},
}:
with python3Packages;
  buildPythonPackage rec {
    pname = "pybars3";
    version = "0.9.7";

    pyproject = true;
    build-system = [python3Packages.setuptools];

    propagatedBuildInputs = [
      PyMeta3
    ];

    doCheck = false;

    src = fetchPypi {
      inherit pname version;
      sha256 = "0lp2q0gazy8nii9g8ybzfszjfpj7234i5wbajddrqfz50pllgj3a";
    };
  }
