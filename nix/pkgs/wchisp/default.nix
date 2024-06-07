{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "wchisp";
  version = "0.3-git";
  src = fetchFromGitHub {
    owner = "ch32-rs";
    repo = pname;
    rev = "4b4787243ef9bc87cbbb0d95c7482b4f7c9838f1";
    hash = "sha256-Ju2DBv3R4O48o8Fk/AFXOBIsvGMK9hJ8Ogxk47f7gcU=";
  };
  cargoHash = "sha256-MbCLQBk7aJXcUOalsNbSxozvI2Tx3kerLXgi4l7BKoc=";
}
