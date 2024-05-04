{
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
  with python3Packages;
    buildPythonPackage rec {
      pname = "pcbnewTransition";
      version = "0.4.1";

      propagatedBuildInputs = [
        kicadPythonModule
        versioneer
      ];

      src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-+mRExuDuEYxSSlrkEjSyPK+RRJZo+YJH7WnUVfjblRQ=";
      };
    }
