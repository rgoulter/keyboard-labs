# Build Guide for CH32X-60-Improved rev2026.1

This document is a guide for soldering the CH32X-60-Improved keyboard.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-60-improved/keyboard-ch32x-60-improved-2026.1-top.jpg" width="600" />

# Required Materials

- 1x CH32X-60-Improved PCB, preassembled with SMT components
  - Available from Elecrow marketplace: [CH32X-60 Improved ANSI Keyboard PCB](https://www.elecrow.com/ch32x-60-improved-ansi-keyboard-pcb.html)
- 66x MX-compatible switches (5-pin)
  - "5-pin" allows for the switches to be mounted to the PCB
    without requiring a switch plate.
- 4x 2U MX stabilizers (PCB mount)
- GH-60 compatible case
- (Optional) Switch plate (1.5mm thick for MX switches)
  - Switch plate is optional if using 5-pin switches.
  - [The SVGs for switch plates can be found on the Release page](https://github.com/rgoulter/keyboard-labs/releases/tag/ch32x-60-improved-rev2026.1)

# Required Soldering Tools

--8<-- "includes/soldering-tools-body.md"

# Flash Firmware and Check PCB Works

Before soldering the switches, you can flash the PCB with firmware
 and check that the PCB works.

You can download a [precompiled firmware binary](https://github.com/rgoulter/keyboard-labs/releases/tag/ch32x-60-improved-rev2026.1)
 from the releases page, then use tweezers or a paperclip
 to short the switch pads (connect the plated circular through-holes together).

Shorting the switch pads together is like pressing the switch,
 so you can visit a keyboard testing website and check each key works.

You can be confident the keyboard works if every key in any column works,
 and every key in any row works.
That is, you don't need to check all 66 keys, you only need to check one row
 and one column.

## Flashing Instructions

--8<-- "includes/flashing-ch32x0-body.md"

# Build Guide

The soldering required for this keyboard is very simple.

1. Mount the 2U stabilizers on the PCB.

2. If you're using a switch plate, arrange the plate to arrange some switches before soldering the switches.

3. Solder the switches.

A switch plate is entirely optional.

If not using a switch plate,
I recommend soldering just one pad of each switch first,
 then checking that the switch is sitting flush on the PCB
 (heat the solder and push the switch against the PCB;
  then remove the iron from the solder, and then stop pushing the switch).
It's easier to correctly align the switches with only one of its pads soldered.

If you didn't flash the firmware before, you'll want to flash the firmware
 before assembling it into the case, since the keyboard PCB's BOOT pads
 can be a bit cumbersome to access when it's in the case.

With the switches soldered, you can then assemble the keyboard into the case,
 and place the keycaps.
