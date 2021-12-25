{ lib
, fetchFromGitHub
, python3Packages
}:

let
  kiauto = python3Packages.buildPythonPackage rec {
    pname = "kiauto";
    version = "1.5.14";

    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "1ppyyr35fa9d6jfl7scrjd3vf4mgavdwn3sd0infrq93lrcb73rw";
    };

    propagatedBuildInputs = with python3Packages; [
      psutil
      xvfbwrapper
    ];

    meta = with lib; {
      homepage = "https://github.com/INTI-CMNB/KiAuto/";
      description = "A bunch of scripts to automate KiCad processes ";
      license = licenses.asl20;
      maintainers = with maintainers; [ ];
    };
  };
in
python3Packages.buildPythonApplication rec {
  pname = "kibot";
  # version = "0.11.0";

  # Newer version has 3D render
  version = "3c4c2f0e1528d04991d96beffdbb3d660668128a";

  # The macros module requires the module isn't compiled.
  # cf. https://github.com/INTI-CMNB/KiBot/issues/31
  postFixup = ''
    find $out -name '__pycache__' | xargs rm -rf
  '';

  propagatedBuildInputs = with python3Packages; [
    colorama
    kiauto
    kicad
    pyyaml
    requests
    XlsxWriter
  ];

  doCheck = false;

  # src = python3Packages.fetchPypi {
  #   inherit pname version;
  #   sha256 = "00fg165j051d8sbmmnk3zj7b3jcz10wywa9075qg0m02r9hvhrmf";
  # };
  # https://github.com/INTI-CMNB/KiBot/commit/3c4c2f0e1528d04991d96beffdbb3d660668128a
  src = fetchFromGitHub {
    owner = "INTI-CMNB";
    repo = "KiBot";
    rev = version;
    sha256 = "1s7hg1bzqg9s9m5213wb672rs1l3xizhn1c8y26jgg68d8ibin7a";
  };
}
