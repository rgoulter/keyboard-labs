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

[![](https://img.youtube.com/vi/g7Msizi1cJ4/0.jpg)](https://www.youtube.com/watch?v=g7Msizi1cJ4)

typing.io:

[![](https://img.youtube.com/vi/Bn727EBErZ0/0.jpg)](https://www.youtube.com/watch?v=Bn727EBErZ0)

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
