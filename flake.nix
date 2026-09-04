{
  description = "Flake for development tooling for Keyboard labs.";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    naersk = {
      url = "github:nmattia/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For the offline ISO,
    # use same version of Nickel as Fak uses.
    nickel = {
      url = "github:tweag/nickel/1.2.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/x86_64-linux";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    devenv,
    flake-parts,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;

      imports = [
        devenv.flakeModule
        ./nix/flake-module.nix
        ./pcb/flake-module.nix
        ./firmware/keyberon/flake-module.nix
      ];
    };
}
