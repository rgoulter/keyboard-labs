{
  projectRootFile = "flake.nix";
  programs.alejandra.enable = true;
  programs.rustfmt.enable = true;
  programs.shellcheck.enable = true;
  programs.shfmt.enable = true;
}
