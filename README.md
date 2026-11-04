# pcbdraw 1.4.0 renders

Images for the pull request that updates the pcbdraw Nix package to 1.4.0.
They are not part of the source tree.

Each image comes from `pcbdraw plot BOARD OUT.svg`
 (with `--side back` for the bottom renders),
 and each PNG from `rsvg-convert` on the matching SVG.

| File prefix | Board file | Before | After |
|---|---|---|---|
| `ch32x-60-improved-*` | `pcb/keyboard-ch32x-60-improved.kicad_pcb` on master | pcbdraw 1.1.3-pre, KiCad 10.0.5 (master `flake.lock`) | pcbdraw 1.4.0, KiCad 10.0.7 |
| `x2-lumberjack-arm-kicad9-*` | `pcb/keyboard-x2-lumberjack-arm.kicad_pcb` at 352b0b5, saved by KiCad 9 | pcbdraw 1.1.3-pre, KiCad 9.0.6 (nixos-25.11) | pcbdraw 1.4.0, KiCad 10.0.7 |

The before PNGs are rendered at the size the SVG declares (about 2.7 mm by 2.2 mm), so they are a few pixels wide.
`x2-lumberjack-arm-kicad9-top-before-overridden.svg` is the before SVG
 with its size and viewBox set to the board area,
 its clip paths and masks removed,
 and the outline stroke width reduced from 59 to 0.15.
