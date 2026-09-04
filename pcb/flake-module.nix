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
      isLinux = pkgs.stdenv.hostPlatform.isLinux;
      pcbPackages =
        if isLinux then
          lib.mapAttrs' (name: p: lib.nameValuePair "pcb-${name}" p)
            (lib.filterAttrs (_: p: lib.isDerivation p) (pkgs.callPackage ./. {}))
        else {};
    in
    {
      checks = lib.optionalAttrs isLinux {
        pcb = pkgs.symlinkJoin {
          name = "keyboard-labs-pcb";
          paths = builtins.attrValues pcbPackages;
        };
      };

      devShells = lib.optionalAttrs isLinux {
        pcb = import ./shell.nix {
          inherit pkgs;
          on-nixos = false;
        };

        pcb-nixos = import ./shell.nix {
          inherit pkgs;
          on-nixos = true;
        };
      };

      packages = lib.optionalAttrs isLinux pcbPackages;
    };
}
