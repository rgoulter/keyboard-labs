{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    naersk = {
      url = "github:nmattia/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs @ {
    self,
    fenix,
    flake-parts,
    naersk,
    nixpkgs,
    systems,
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;
      imports = [
        ./flake-module.nix
      ];
      perSystem = {
        self',
        config,
        pkgs,
        system,
        ...
      }: {
        devShells.default = self'.devShells.firmware-keyberon;
      };
    };
}
