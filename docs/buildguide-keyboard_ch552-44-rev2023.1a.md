# Build Guide for CH552-44 rev2023.1a

This document is a guide for soldering the CH552-44 keyboard.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-44/ch552_44-sandwich-top.JPG" width=600 />

# Required Materials

- 1x PCB
- 1x WeAct Studio CH552 development board
- 44x MX-compatible 5-pin switches
  - 3-pin switches can be used, if using a switch plate.
- Case or bottom plate.
- M2 screws, for mounting PCB to the case.
  - e.g. for sandwich style (bottom plate):
    - 5x PM M2x3mm screws
    - 5x PM M2x5mm screws
    - 5x M2 4mm brass female-female spacers

- Optionally:
  - For mounting the devboard,
     the male header pins which come with the devboard are sufficient.
    For mounting the devboard higher:
    - 1x 1x40 SIP round-pin male headers,
    - 1x 1x40 SIP round-pin female header sockets.
  - A plate for the key switches would improve the keyboard quality;
    get this lasercut from 1.5mm thick.


# Required Soldering Tools

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/tools.JPG" />

See [docs/soldering-tools.md](../docs/soldering-tools.md)

# Build Guide

The soldering required for this keyboard is very simple. (Simpler than soldering practice kits).

1. Solder the diodes for the switches.

2. Solder the dev board (and whatever headers for the dev board).
   (Since the CH552-44 uses P1.2 and P1.3, ensure SB1 is bridged, and SB2 is bridged).

3. Using the switch plate to align the switches, solder the switches in.

## Notes

- Diode direction: the cathode (negative, marked side) should be soldered
  towards the through-hole pad which is shaped like a square.
  e.g. compare with this render (of a different PCB):

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/render-kicad-keyboard-pico42-back-diodes.png" />

- The CH552 core board can also be soldered onto round-pin headers,
  instead of the square-pin headers that come with the devboard.
  - By socketing the dev-board using round-pin female headers (and maybe round-pin male headers),
    the dev board still is below the height of MX switches, but sits high enough
    to mount the PCB in the low-profile JJ40 case.
    - Socketing also allows easily removing/replacing the dev board.

## Entering Bootloader Mode for the CH552

You can enter the bootloader on the CH552 by holding the P3.6 button
when connecting the dev board to the computer.

Then the keyboard firmware can be flashed onto the MCU.
