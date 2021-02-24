# Keyboard Labs

This repository contains the source files for keyboard
designs and keyboard firmware.

## Keyboards

Source files under `pcb`.

The keyboard PCBs have been designed in KiCad.
These projects can be plotted to gerbers and fabricated.

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

## Firmware

Source files under `firmware`.

The keyboard firmware is written in Rust using the keyberon
firmware.
