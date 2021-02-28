# Keyboard Labs

This repository contains the source files for keyboard
designs and keyboard firmware.

## Keyboards

Kicad source files are in `pcb`.

Plotted gerber files can be found in [releases](https://github.com/rgoulter/keyboard-labs/releases/).

#### 36-key, split, reversible PCB with WeAct Studio Mini F4 dev board

![](https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboard1_final_result.jpg)

Design goals:

- PCB smaller than 100x100 mm2,
  so that it's cheaper to fabricate at various
  PCB fabricators.
- Reversible PCB (use the same PCB for left/right halves).
- Using the WeAct Studio MiniF4 "black pill" dev board.
- Low profile (PCB + choc switches + bumpons).
- Column-staggered arrangement of key switches.
- Per-key RGB LEDs.

## CAD Designs

#### Tenting Stand

`keyboard_tenting_stand.scad` describes a design which can be laser cut
and assembled to form an adjustable tenting stand.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/tenting_stand_3d_preview.png" width=700 />

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/tent_puzzle_all.svg" width=700 />

## Firmware

Source files under `firmware`.

The keyboard firmware is written in Rust using the keyberon
firmware.
