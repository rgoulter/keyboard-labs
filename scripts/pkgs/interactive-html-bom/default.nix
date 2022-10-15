{
  stdenv,
  fetchFromGitHub,
  python3,
  writeScriptBin,
  kicad,
}: let
  kicadPythonModule =
    toPythonModule
    (kicad.override {
      inherit python3;
    })
    .src;
  interactive-html-bom = stdenv.mkDerivation rec {
    pname = "interactive-html-bom";
    version = "2.4.1";

    src = fetchFromGitHub {
      owner = "openscopeproject";
      repo = pname;
      rev = "v${version}";
      sha256 = "09c2q9735jsy5q1ny6rkr757vvg6nr36ix9hslb78yh9r5jlg6rb";
    };

    installPhase = ''
      mkdir -p $out/
      cp -r . $out
    '';

    patches = [./remove-footprint-from-default-group-field.patch];
  };
  python-with-my-packages = python3.withPackages (p:
    with p; [
      kicadPythonModule
      wxPython_4_1
    ]);
in
  writeScriptBin "InteractiveHtmlBom" ''
    ${python-with-my-packages}/bin/python ${interactive-html-bom}/InteractiveHtmlBom/generate_interactive_bom.py $*
  ''
