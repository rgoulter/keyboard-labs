{
  lib,
  ...
}: {
  flake.nixosModules = import ./nixosModules;

  perSystem =
    {
      pkgs,
      ...
    }:
    let
      qmkPackages =
        lib.mapAttrs' (name: p: lib.nameValuePair "qmk-${name}" p)
          (lib.filterAttrs (_: p: lib.isDerivation p) (pkgs.callPackage ./pkgs/qmk {}));
    in
    {
      packages =
        {
          gcc-arm-a-embedded = pkgs.callPackage ./pkgs/gcc-arm-a-embedded {};
          uf2conv = pkgs.callPackage ./pkgs/uf2conv {};
          wchisp = pkgs.callPackage ./pkgs/wchisp {};
        }
        // qmkPackages;
    };
}
