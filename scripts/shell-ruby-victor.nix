with (import <nixpkgs> {});
let
  gems = bundlerEnv {
    name = "keyboard-labs-ruby-bundle";
    inherit ruby;
    gemdir = ./.;
  };
in stdenv.mkDerivation {
  name = "keyboard-labs-ruby";
  buildInputs = [
    gems
    ruby
  ];
}
