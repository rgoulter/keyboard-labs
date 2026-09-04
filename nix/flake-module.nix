{
  lib,
  ...
}: {
  flake.nixosModules = import ./nixosModules;

  perSystem =
    {
      pkgs,
      system,
      ...
    }:
    let
      isLinux = pkgs.stdenv.hostPlatform.isLinux;
      isX86_64Linux = system == "x86_64-linux";
      qmkPackages =
        if isLinux then
          lib.mapAttrs' (name: p: lib.nameValuePair "qmk-${name}" p)
            (lib.filterAttrs (_: p: lib.isDerivation p) (pkgs.callPackage ./pkgs/qmk {}))
        else {};
    in
    {
      packages =
        {
          uf2conv = pkgs.callPackage ./pkgs/uf2conv {};
          wchisp = pkgs.callPackage ./pkgs/wchisp {};
        }
        // lib.optionalAttrs isX86_64Linux {
          gcc-arm-a-embedded = pkgs.callPackage ./pkgs/gcc-arm-a-embedded {};
        }
        // qmkPackages;

      devShells = {
        # Portable shell with basic dev tools (just, make, etc.) — available on Linux and Darwin.
        # Heavier Linux-only shells (pcb) and Rust firmware shells are defined elsewhere.
        tools = pkgs.mkShell {
          packages = [
            pkgs.just
            pkgs.gnumake
          ];
        };
      };
    };
}
