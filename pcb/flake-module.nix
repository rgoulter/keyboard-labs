{
  lib,
  ...
}: {
  perSystem =
    {
      pkgs,
      ...
    }:
    let
      pcbPackages =
        lib.mapAttrs' (name: p: lib.nameValuePair "pcb-${name}" p)
          (lib.filterAttrs (_: p: lib.isDerivation p) (pkgs.callPackage ./. {}));
    in
    {
      checks.pcb = pkgs.symlinkJoin {
        name = "keyboard-labs-pcb";
        paths = builtins.attrValues pcbPackages;
      };

      devShells = {
        pcb = import ./shell.nix {
          inherit pkgs;
          on-nixos = false;
        };

        pcb-nixos = import ./shell.nix {
          inherit pkgs;
          on-nixos = true;
        };
      };

      packages = pcbPackages;
    };
}
