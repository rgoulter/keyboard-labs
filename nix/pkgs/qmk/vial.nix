{
  lib,
  stdenv,
  fetchFromGitHub,
  qmk,
  rsync,
}: {
  keyboard,
  keymap,
  env ? [],
  extra_files ? [
    ../../../firmware/qmk
    ../../../firmware/vial
  ],
  output_extension ? "uf2",
}:
stdenv.mkDerivation rec {
  pname = "${keyboard}:${keymap}";
  version = "0.22.10";

  doCheck = false;

  src = fetchFromGitHub {
    owner = "vial-kb";
    repo = "vial-qmk";
    rev = "f06a05a5d5e2e4e92d4ae28628cebaba2b9c32f0"; # vial
    sha256 = "sha256-chYzftrivOgA39ZOAvt374a0yRlTtzE8lI7z7y9GKLU=";
    fetchSubmodules = true;
  };

  patchPhase = ''
    # Bug: for some reason, the rsync command needs this?
    mkdir -p keyboards/rgoulter
    for extra in ${lib.strings.concatStringsSep " " extra_files}; do
      ${rsync}/bin/rsync --recursive $extra/ .
    done
  '';

  buildPhase = let
    envArg = lib.strings.concatMapStrings (e: " --env " + e) env;
  in ''
    ${qmk}/bin/qmk compile --keyboard ${keyboard} --keymap ${keymap} ${envArg}
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp .build/*.${output_extension} "$out/bin/firmware.${output_extension}"
  '';

  dontFixup = true;
}
