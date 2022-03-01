[Nix](https://nixos.org/) is a fancy package manager.

"Nix classic" refers to the older channel-oriented commands such as
`nix-shell`.

There are some files named `shell-*.nix` in the `scripts/` directory,
documented below:

### shell-kibot.nix

[KiBot](https://github.com/INTI-CMNB/KiBot) can be used to generate
assets for the KiCad PCBs in this project's `pcb/` directory.

With Nix installed, run:

```
nix-shell shell-kibot.nix
```

This provides a shell which has `kibot` on its `PATH`.

### shell-interactive-html-bom.nix

Provides a standalone script of
[InteractiveHtmlBom](https://github.com/openscopeproject/InteractiveHtmlBom),
`InteractiveHtmlBom`.

The script requires that the netlist be generated from eeschema,
so that symbol fields (like comment, description) can be used in the ibom.

Some convenience scripts e.g. `generate-x1-ibom.sh` are provided which can
be called with:

```
nix-shell generate-x1-ibom.sh
```
