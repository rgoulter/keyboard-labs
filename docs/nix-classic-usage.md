[Nix](https://nixos.org/) is a fancy package manager.

"Nix classic" refers to the older channel-oriented commands such as
`nix-shell`.

There are some files named `shell.nix` or `shell-*.nix` throughout the repository.

### pcb/shell.nix

[KiBot](https://github.com/INTI-CMNB/KiBot) can be used to generate
assets for the KiCad PCBs in this project's `pcb/` directory.

With Nix installed, run:

```
nix-shell pcb/shell.nix
```

This provides a shell which has `kibot` on its `PATH`.

The shell also provides a standalone script of
[InteractiveHtmlBom](https://github.com/openscopeproject/InteractiveHtmlBom),
`InteractiveHtmlBom`.

Some convenience scripts e.g. `generate-x1-ibom.sh` are provided which can
be called with:

```
nix-shell generate-x1-ibom.sh
```

These `scripts/generate-*-ibom.sh` scripts can also be called from `make` in the `pcb/` directory.
