{ fetchFromGitHub
, python3
, writeScriptBin
}:

let
  uf2 = fetchFromGitHub {
    owner = "microsoft";
    repo = "uf2";
    rev = "4a51fe51751eb9b87c4d652793669568d7f0f96e";
    sha256 = "sha256-uAPEmXZ2Hu3Bylt3/2LmwDeNkL6NAIUwJpcsq2qHgm4=";
  };
in
writeScriptBin "uf2conv" ''
${python3}/bin/python ${uf2}/utils/uf2conv.py $*
''
