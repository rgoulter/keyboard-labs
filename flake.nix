{
  description = "Flake for development tooling for Keyboard labs.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-with-kicad5 = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "89f196fe781c53cb50fef61d3063fa5e8d61b6e5";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-with-kicad5, flake-utils }:
    flake-utils.lib.eachSystem [
      flake-utils.lib.system.x86_64-linux
    ] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-with-kicad5 = nixpkgs-with-kicad5.legacyPackages.${system};
      bootloaders = import ./scripts/bootloaders.nix {
        inherit pkgs;
      };
    in {
      packages = {
        bootloader-stm32f103-stm32duino = bootloaders.stm32f103.stm32duino;
        bootloader-stm32f401-tinyuf2 = bootloaders.stm32f401.tinyuf2;
        bootloader-stm32f411-tinyuf2 = bootloaders.stm32f411.tinyuf2;
        docker-kibot-kicad-5 = import ./scripts/docker-kibot.nix {
          pkgs = pkgs-with-kicad5;
          tag = "kicad-5";
        };
        docker-kibot-kicad-6 = import ./scripts/docker-kibot.nix {
          pkgs = pkgs;
          tag = "kicad-6";
        };
        kicad-6 = pkgs.kicad;
      };
      devShells = {
        kibot-kicad5 = import ./scripts/shell-kibot.nix {
          pkgs = pkgs-with-kicad5;
          on-nixos = false;
        };

        kibot-kicad6 = import ./scripts/shell-kibot.nix {
          pkgs = pkgs;
          on-nixos = false;
        };

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
