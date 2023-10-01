# Build Guide for Pico42 rev2023.1

This document is a guide for soldering the Pico42 keyboard.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/pico42-mx_lowprofile_case.JPG" />

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/pico42-choc_sandwich.JPG" />

# Required Materials

<img src="https://github.com/rgoulter/keyboard-labs/blob/master/docs/images/buildlog-rev2021.4-minimal/bom-soldering-switches.JPG" />

- 1x PCB
- 1x Raspberry Pi "Pico" development board
- 42x MX-compatible switches, or Kailh Choc v1 switches.
- (Optional) Socketing headers:
  - 1x 1x40 SIP round-pin male headers,
  - 1x 1x40 SIP round-pin female header sockets.
- Switch plate (1.5mm thick for MX switches, 1.0mm thick for Choc switches)
  - Switch plate is optional if using 5-pin switches.
- Case or bottom plate.
- M2 screws, for mounting PCB to the case.
  - e.g. for sandwich style (switch plate + bottom plate):
    - 4x PM M2x3mm screws
    - 5x PM M2x5mm screws
    - 5x M2 4mm brass female-female spacers

# Required Soldering Tools

<img src="https://github.com/rgoulter/keyboard-labs/blob/master/docs/images/buildlog-rev2021.4-minimal/tools.JPG" />

See <../docs/buildguide_rev2021.4_budget.md#required-soldering-tools>

# Build Guide

The soldering required for this keyboard is very simple. (Simpler than soldering practice kits).

1. Solder the diodes for the switches.

2. Solder the dev board (and whatever headers for the dev board).

3. Using the switch plate to align the switches, solder the switches in.

## Notes

- Diode direction: the cathode (negative, marked side) should be soldered
  towards the through-hole pad which is shaped like a square.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/render-kicad-keyboard-pico42-back-diodes.png" />

- Mounting the dev board:
  - Since the Pico has castellated edges,
    the dev board can be soldered directly to the Pico42 PCB.
  - The Pico can also be soldered onto headers, which allows
    the dev board to sit higher.
    - By socketing the dev-board using round-pin male headers, and round-pin female headers,
      the dev board still is below the height of MX switches, but sits high enough
      to mount the PCB in the low-profile JJ40 case.
      - Socketing also allows easily removing/replacing the dev board.

## Flashing the Pico

You can enter the bootloader on the Raspberry Pi Pico
(which shows a drive labelled "RPI-RP2") by holding the BOOTSEL button
when connecting the dev board to the computer.

The UF2 file for the firmware (e.g. CircuitPython for KMK, or the UF2 from QMK)
can then be copy-pasted onto this drive.
