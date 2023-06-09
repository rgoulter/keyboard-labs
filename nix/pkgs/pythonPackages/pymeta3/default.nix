{python3Packages}:
with python3Packages;
  buildPythonPackage rec {
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
  }
