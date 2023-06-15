{
  lib,
  qmk,
  stdenv,
  fetchFromGitHub,
}: {
  keyboard,
  keymap,
  extra_files ? ../../../firmware/qmk,
  output_extension ? "uf2",
}:
stdenv.mkDerivation rec {
  pname = "${keyboard}:${keymap}";
  version = "0.21.1";

  doCheck = false;

  src = fetchFromGitHub {
    owner = "qmk";
    repo = "qmk_firmware";
    rev = version;
    sha256 = "sha256-flR3sjynN25pkGGlxY7pCjYzSP/+civbXNiQtuZi7xM";
    fetchSubmodules = true;
  };

  patchPhase = ''
    cp -r ${extra_files}/* .
  '';

  buildPhase = ''
    ${qmk}/bin/qmk compile --keyboard ${keyboard} --keymap ${keymap}
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp .build/*.${output_extension} "$out/bin/firmware.${output_extension}"
  '';

  dontFixup = true;
}
