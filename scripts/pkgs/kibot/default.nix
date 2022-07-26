{ lib
, fetchFromGitHub
, python3Packages
, use-vglrun ? false
, python3
, kicad
}:

let
  kicadPythonModule = python3Packages.toPythonModule (kicad.override {
    inherit python3;
  }).src;
  kiauto = python3Packages.buildPythonPackage rec {
    pname = "kiauto";
    version = "1.6.15";

    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-ogWyJLORfZRP4d0z5BZaKG3WoXuEWNJycMAqNPI19ug=";
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
      maintainers = with maintainers; [ ];
    };

    # Kludge:
    # On NixOS desktop, in order to run Kicad within Xvfb
    # I used VirtualGL's `vglrun`.
    patches =
      lib.optional use-vglrun ./kiauto-pcbnew_do-cmd-vglrun-display1.patch;
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
      maintainers = with maintainers; [ ];
    };
  };
in
python3Packages.buildPythonApplication rec {
  pname = "kibot";
  version = "2_1_2_0";

  # The macros module requires the module isn't compiled.
  # cf. https://github.com/INTI-CMNB/KiBot/issues/31
  postFixup = ''
    find $out -name '__pycache__' | xargs rm -rf
  '';

  propagatedBuildInputs = with python3Packages; [
    colorama
    kiauto
    kicadPythonModule
    pyyaml
    qrcodegen
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
    rev = "v${version}";
    sha256 = "sha256-nU3GUsWs+7ByghAcFyAmRTv2fHWArr50qtYHyoQAwPE=";
  };
}
