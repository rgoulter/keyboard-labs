# pcbdraw 1.4.0 renders

Images for the pull request that updates the pcbdraw Nix package to 1.4.0.
They are not part of the source tree.

Each image comes from `pcbdraw plot BOARD OUT.svg`
 (with `--side back` for the bottom renders),
 and each PNG from `rsvg-convert -w 1600` on the matching SVG.

The `ch32x-60-improved-*` files compare two versions on `pcb/keyboard-ch32x-60-improved.kicad_pcb`.
The before files come from pcbdraw 1.1.3-pre with KiCad 10.0.5 (the master `flake.lock`),
 and the after files from pcbdraw 1.4.0 with KiCad 10.0.7.
The before PNGs are rendered at the size the SVG declares (about 2.7 mm by 2.2 mm),
 so they are a few pixels wide.

`all-boards/` holds pcbdraw 1.4.0 renders, with KiCad 10.0.7,
 of each `pcb/keyboard-*.kicad_pcb` board on the `pcbdraw-1.4` branch.
Seven boards are missing because unpatched pcbdraw 1.4.0 fails on them;
 the pull request description lists them.

`layer-names/` holds renders from pcbdraw 1.4.0 with `nix/pkgs/pcbdraw/layer-user-names.patch`
 (on the `pcbdraw-layer-names` branch), with KiCad 10.0.7.
It covers the seven boards that give their copper layers user names,
 and `keyboard-ch32x-36-lhs`, whose SVGs are byte-identical to the unpatched renders in `all-boards/`.

`bare/` holds renders of each `pcb/keyboard-*.kicad_pcb` board
 from `pcbdraw plot --no-components` on the rebased `pcbdraw-1.4` branch (3b1da75),
 with pcbdraw 1.4.0, the layer name patch, and KiCad 10.0.5 from the master `flake.lock`.
The `ch32x-60-improved-*-after` files are copies of the matching `bare/` renders.
