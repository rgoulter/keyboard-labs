{
  pkgs ?
    import (builtins.fetchGit {
      name = "nixpkgs-with-kicad5";
      url = "https://github.com/NixOS/nixpkgs/";
      ref = "refs/heads/nixpkgs-unstable";
      rev = "89f196fe781c53cb50fef61d3063fa5e8d61b6e5";
    }) {},
  docker-image-name ? "richardgoulter/kibot",
  tag ? "latest",
  kicad-with3d ? true,
}:
with pkgs; let
  my-kicad = pkgs.kicad.override {
    pname = "kicad-docker";
    # Build without OCC so that the Docker image is smaller
    withOCC = false;
    with3d = kicad-with3d;
  };
  kibot = callPackage ./pkgs/kibot {
    kicad = my-kicad;
    use-vglrun = false;
  };
  pcbdraw = callPackage ./pkgs/pcbdraw {kicad = my-kicad;};
  recordmydesktop = callPackage ./pkgs/recordmydesktop {};
in
  pkgs.dockerTools.buildLayeredImage {
    inherit tag;

    name = docker-image-name;

    extraCommands = "mkdir -m 0777 tmp";

    contents = [
      bash
      coreutils
      kibot
      pcbdraw
      xdotool
    ];

    config = {
      Env = [
        "KICAD_SYMBOL_DIR=${kicad.libraries.symbols}/share/kicad/library"
      ];
    };
  }
