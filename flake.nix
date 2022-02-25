{
  description = "Flake for development tooling for Keyboard labs.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "1882c6b7368fd284ad01b0a5b5601ef136321292";
    };

    nixpkgs-with-kicad5 = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "89f196fe781c53cb50fef61d3063fa5e8d61b6e5";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-with-kicad5, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-with-kicad5 = nixpkgs-with-kicad5.legacyPackages.${system};
    in {
      devShells = {
        kibot-kicad5-nixos = import ./scripts/shell-kibot.nix {
          pkgs = pkgs-with-kicad5;
          on-nixos = true;
        };

        kibot-kicad6-nixos = import ./scripts/shell-kibot.nix {
          pkgs = pkgs;
          on-nixos = true;
        };
      };
    });
}
