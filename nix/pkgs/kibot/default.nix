{
  lib,
  fetchFromGitHub,
  python3Packages,
  python3,
  kicad,
  kiauto ?
    import ../pythonPackages/kiauto {
      inherit
        lib
        python3Packages
        python3
        kicad
        ;
    },
  pcbdraw ?
    import ../pcbdraw {
      inherit
        lib
        fetchFromGitHub
        python3Packages
        python3
        kicad
        ;
    },
  qrcodegenPythonModule ?
    import ../pythonPackages/qrcodegen {
      inherit
        lib
        fetchFromGitHub
        python3Packages
        ;
    },
}: let
  kicadPythonModule =
    python3Packages.toPythonModule
    (kicad.override {
      inherit python3;
    })
    .src;
in
  python3Packages.buildPythonApplication rec {
    pname = "kibot";
    version = "1.9.1";

    pyproject = true;
    build-system = [python3Packages.setuptools];

    # The macros module requires the module isn't compiled.
    # cf. https://github.com/INTI-CMNB/KiBot/issues/31
    postFixup = ''
      find $out -name '__pycache__' | xargs rm -rf
    '';

    propagatedBuildInputs = with python3Packages; [
      colorama
      kiauto
      kicadPythonModule
      lark
      lxml
      markdown2
      pcbdraw
      pyyaml
      qrcodegenPythonModule
      requests
      xlsxwriter
    ];

    doCheck = false;

    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-mBfKykgLQtzQ0iQ0fI1+Pg7BU4nT3hj6Gup3MVnrx3E=";
    };
  }
