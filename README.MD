# Keyboard Labs

This repository contains the source files for keyboard
designs and keyboard firmware.

## Keyboards

Kicad source files are in `pcb`.

Plotted gerber files can be found in [releases](https://github.com/rgoulter/keyboard-labs/releases/).

#### 36-key, split, reversible PCB with WeAct Studio Mini F4 dev board

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboard_100x100_minif4-36key_rev2021.1mx-pair_tented-displayed.JPG"  width=600 />

_Keyboard, rev2021.1, MX variation_

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboard_100x100_minif4-36key_rev2021.1mx-pair_tented-reverse.JPG"  width=600 />

_Keyboard rev2021.1, MX variation_

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboard_100x100_minif4-36key_rev2020.1-pair_flat.JPG"  width=600 />

_Keyboard rev2020.1_

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboard_100x100_minif4-36key_compare-rev2020.1-rev2021.1mx-flat.JPG"  width=600 />

_Comparison between rev2020.1 low-profile and rev2021.1 MX with lasercut sandwich case_

Design goals:

- PCB smaller than 100x100 mm2,
  so that it's cheaper to fabricate at various
  PCB fabricators.
- Reversible PCB (use the same PCB for left/right halves).
- Using the WeAct Studio MiniF4 "black pill" dev board.
- Low profile (PCB + choc switches + bumpons).
- Column-staggered arrangement of key switches.
- Per-key RGB LEDs.

###### Typing Demonstration Videos

typings.gg:

<iframe width="560" height="315" src="https://www.youtube.com/embed/g7Msizi1cJ4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

typing.io:

<iframe width="560" height="315" src="https://www.youtube.com/embed/Bn727EBErZ0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## CAD Designs

CAD design files found under `cad/`:

#### Tenting Stand

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboard_100x100_minif4-36key_rev2021.1mx-pair_tented.JPG"  width=600 />

`keyboard_tenting_stand.scad` describes a design which can be laser cut
and assembled to form a adjustable tenting stand. The stand can be adjusted
using an extra wedge piece.

The design accepts various parameters (e.g. width, height, angle, screw diameter).

## Firmware

Source files under `firmware`.

The keyboard firmware is written in Rust using the keyberon
firmware.

## Scripts

### Kicad PCB to OpenSCAD

Script to generate OpenSCAD files from `.kicad_pcb` files.
See: [scripts/README.MD](https://github.com/rgoulter/keyboard-labs/tree/master/scripts#transform-kicad_pcb-to-scad)

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/openscad_plate1.png"  width=600 />
