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
  version = "0.22.10";

  doCheck = false;

  src = fetchFromGitHub {
    owner = "qmk";
    repo = "qmk_firmware";
    rev = version;
    sha256 = "sha256-GHkcOulb0jM2y5DkOU4izEdQvzyv9uFa93kPWfxVUvc=";
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
