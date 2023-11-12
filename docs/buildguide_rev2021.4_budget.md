# Build Guide for rev2021.4

This document is a guide for soldering a minimal build of the MiniF4
36-key split keyboard.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/result.JPG" />

A companion video showing the soldering can be found here:

[![](https://img.youtube.com/vi/zhKnluxdRtA/0.jpg)](https://www.youtube.com/watch?v=zhKnluxdRtA)

### Advantages

* Minimal:
  * This build can be completed with a minimum of parts.
  * Only a minimal soldering set required.
  * Only simple soldering. No prior soldering experience.
  * Since it does not involve diodes, there are fewer things which can
    go wrong.

### Disadvantages

* This keyboard has only 36 keys.
  * This can take some time to get used to.
  * May not be ideal for tasks which involve use of mouse-and-keyboard.

* This is a minimal, budget-oriented build.
  * The keyboard is just the PCB and some switches.
  * No plate/case.
  * The resulting build doesn't feel as nice as if it were built with
    a plate or a case.

# Budget-Focussed Alternatives

Other budget-oriented ways to build a keyboard:

### Other Small PCBs

The steps in this build guide will more/less apply to
other keyboard PCB designs.

Other keyboard PCBs will be similarly cheap to fabricate/assemble if
the PCB is also smaller than 100x100mm.

The most common development board used in such keyboards is the Pro Micro,
which isn't as powerful as the WeAct Studio MiniF4 "black pill".
There are development boards which are compatible with the Pro Micro while
being more powerful, but these are more expensive. (Otherwise everyone would
just use those in their builds).

### Hand-Wired Keyboard

It's likely to be cheaper to build a hand-wired keyboard.

This would involve getting a case by lasercutting plates,
and hand-wiring the switches to the microcontroller development board.

The advantage to building a hand-wired keyboard is you've
got more flexibility in terms of keyboard shape/size.

Compared to the build in this guide,
the disadvantage to the hand wired keyboard
is that it requires more fiddling with wires, and the result might not look
as nice despite taking more effort.

# Required Materials

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/bom-soldering-switches.JPG" />

- 2x PCBs
- 6x 2.4k Ohm 1/4W through-hole resistors
- 2x PJ-320A TRRS jack
- 2x WeAct Studio MiniF4 "Black Pill" development boards
  - WeAct Studio endorsed links can be found on [their repository's README](https://github.com/WeActTC/MiniSTM32F4x1#legitimate-purchase-links-as-well-as-pirated-links)
- 2x 1x40 SIP round female header sockets or 2x DIP40 round pin socket and 2x 1x40 SIP round male header sockets
- 36x MX-compatible switches
- 36x keycaps, compatible with the MX switches
- 10x Bumpons, 5mm x 2mm.
- 1x TRRS cable
- 1x USB-C cable

## Socketing Alternative

The round SIP headers are for socketing the development board. i.e.
making it so that it's easy to remove and replace the development
board.

Using DIP40 sockets instead of SIP 1x20 female headers makes it
somewhat easier to assemble.

Instead of the round male header pins, it is also possible to socket
the development board using tinned wire (e.g. stripping wrapping
wire). This results in the development board sitting lower, but
requires more effort than just using the male header pins.

If you're confident, then you could directly solder the development
board using the male headers provided with the development board,
rather than socketing.

# Required Soldering Tools

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/tools.JPG" />

See [docs/soldering-tools.md](../docs/soldering-tools.md)

It's also useful to have:

- ST-Link v2 STM32 programmer.
  - The STM32F4 comes with a DFU bootloader. i.e. In theory, the
    STM32F4 board can be flashed without needing the ST-Link. In my
    experience, this can be finicky and unreliable; so I recommend
    using an ST-Link. The cheap knock-offs work.

# Summary

- Solder the resistors at R1, R2.
- Solder one of the resistors from PA9 (labelled SW13) to 5V or 3V3.
  - It's more convenient to use the plated through hole pads for the 'reverse' side of the board.
- For the Right-Hand Side, solder jumpers JP1, JP2.
- Solder the TRRS jack at J1/J2.
- Solder female headers in appropriate pads at U1,
  and solder the microcontroller to the male header pins.
- Solder in the switches.

# Build Guide

For each half:

1. Insert the through-hole resistors.

    Insert resistors into the through-hole pads
    at R1, R2.

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/1-resistors-placed.JPG" />
    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/1-resistors-placed-bottom.JPG" />

    To work around
    [qmk/qmk_firmware#7855](https://github.com/qmk/qmk_firmware/issues/7855),
    an external pullup resistor is needed from A9 to 5V or 3V3.
    Compare the location of these pins on the PCB, with where the
    resistor is placed in the image. (If using DIP40 socket for the
    microcontroller, etiher take care to position the resistor so it
    doesn't obstruct where the DIP socket goes, or cut the DIP
    socket).

    i.e. on the Left Hand Side, you'll want to pull up:

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/pcb_u1_sw13_external_pullup-lhs.png" />

    and the Right Hand Side:

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/pcb_u1_sw13_external_pullup-rhs.png" />

2. Solder the resistors.

    If you've never soldered before, best to search for "how to solder
    through hole components" to get an idea of what it should look
    like.

   Use the flush cutters to cut the legs of the soldered resistors.
    Take care to protect your eyes when using the flush cutters
    (e.g. by wearing safety glasses).

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/2-resistors-soldered-bottom.JPG" />

3. *For the Right-Hand Side PCB only*: On the top-side of the PCB, use solder to bridge JP1 and JP2
    to either 1 or 3.

    Currently, the QMK firmware only supports JP1 and JP2 jumped to 1,
    the Keyberon firmware only supports JP1 and JP2 jumped to 3.

    i.e. for QMK, it should look like:

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/0-jumpers-i2c.JPG" width=450 />

    i.e. for Keyberon, it should look like:

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/0-jumpers-uart.JPG" width=450 />

4. Solder the TRRS jack.

    Place the TRRS jack on the top-side of the PCB.

    Solder one pad first, check that the jack sits flush with the PCB.
    It's easier to heat the soldering and adjust the positioning of the
    TRRS jack with only one pad soldered.

    Solder the remaining pads once once it's in place.

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/3-trrs-jack-soldered.JPG" />

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/3-trrs-jack-soldered-bottom.JPG" />

5. Solder in the female headers and/or socket.

    Cut each of the 1x40 headers in half so that they can be used to
    socket the PCB and microcontroller.

    I suggest first soldering in the pins at the
    end, then insert the round-pin male headers.
    Ensure that the development board sits evenly.

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/4-headers-placed.JPG" />

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/4-headers-placed-and-mated.JPG" />

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/4-headers-placed-and-mated-with-mcu.JPG" />

    Then solder the rest of the female header pins.

    The soldering can be 'tidied' a bit by cutting the soldered pins
    flush with the board, and then adding a bit more solder so the
    soldering is 'round'. c.f.
    <https://makerprojectlab.com/how-to-make-beautiful-solder-joints/>

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/6-headers-soldered-trimmed-bottom.JPG" />

6. Solder the development board to the round male header pins.

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/7-mcu-soldered.JPG" />

7. Insert the MX switches. Ensure each sits flush
    with the PCB.

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/8-switches-placed.JPG" />

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/8-switches-placed-bottom.JPG" />

    Solder both legs of each switch. Take care to not create shorts
    between the adjacent pads.

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/9-switches-soldered.JPG" />

    All the soldering is finished.

8. Complete the assembly by placing the keycaps.

    Also place bumpons on the underside of the PCB.

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/10-bumpons-applied-bottom.JPG" />

    See the repository's readme for instructions on building and
    flashing the firmware.

    <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/result.JPG" />

## Explanation of JP1 and JP2 Bridging for Keyboard Firmware Implemenations

The keyboard firmware using keyberon
uses UART to support the split keyboard functionality.
(i.e. LHS's 'TX' should be connected to RHS's 'RX'). The QMK
firmware relies on QMK's split-common serial transport.
(i.e. LHS's 'SCL' should be connected to RHS's 'SCL').

Compare the schematic:

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/schematic_trrs_jp1andjp2.png" />

with JP1 and JP2 bridged to 1:

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/schematic_trrs_jp1andjp2-i2c.png" />

with JP1 and JP2 bridged to 3:

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/buildlog-rev2021.4-minimal/schematic_trrs_jp1andjp2-uart.png" />
