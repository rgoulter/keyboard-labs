{ lib
, fetchFromGitHub
, python3Packages
}:
with python3Packages;
let
  pcbnewTransition = buildPythonPackage rec {
    pname = "pcbnewTransition";
    version = "0.2.0";

    propagatedBuildInputs = [
      kicad
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
    version = "1.4.4";

    propagatedBuildInputs = [
      numpy
      scipy
      svgwrite
    ];

    src = fetchPypi {
      inherit pname version;
      sha256 = "0jsmaflk0zsv9yyksi5a25ii6mya5s91bqq41kqi71ia7716074y";
    };
  };
in
buildPythonApplication rec {
  pname = "pcbdraw";
  version = "0.7.1";

  propagatedBuildInputs = [
    click
    lxml
    mistune
    numpy
    pcbnewTransition
    pybars3
    pyyaml
    svgpathtools
    Wand
  ];

  # INTI-CMNB (GitHub owner of KiBot) also maintains a fork
  # https://github.com/INTI-CMNB/PcbDraw
  src = fetchFromGitHub {
    owner = "yaqwsx";
    repo = "PcbDraw";
    rev = "v${version}";
    sha256 = "0xvx2cdahnbrhm26alj054ma1qlbfssqrad3vf58hjifn2dmhcs7";
  };

}
