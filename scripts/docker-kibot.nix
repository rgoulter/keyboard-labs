{
  pkgs,
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
  kibot = callPackage ../nix/pkgs/kibot {
    kicad = my-kicad;
    use-vglrun = false;
  };
  pcbdraw = callPackage ../nix/pkgs/pcbdraw {kicad = my-kicad;};
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
