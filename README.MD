# Keyboard Labs

This repository contains the source files for keyboard
designs and keyboard firmware.

## Keyboards

Kicad source files are in `pcb`.

Plotted gerber files can be found under the GitHub repository's
[releases](https://github.com/rgoulter/keyboard-labs/releases/).

| Designation | Summary/Keywords                                                                 | Image                                                                                                                                                 |
|-------------|----------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| X-1         | 36-key (2x3x5+3), split, column-staggered, MX/choc, sub-100x100, per-key RGB LED | ![](https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1_rev2021.5-mx-top.JPG) |
| X-2         | 60-key (5x12), un-split, ortholinear, MX/choc, GH60-compatible, "show the components"  | ![](https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-2_rev2021.1-mx-top.JPG)     |

#### X-1: 36-key, split, reversible PCB with WeAct Studio Mini F4 dev board

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1_rev2021.5-mx-top.JPG" width=600 />

_X-1, rev2021.5, MX variation (with rotary encoder, OLED, etc.)._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1_rev2021.5-choc-top.JPG" width=600 />

_X-1, rev2021.5, Choc variation, low-profile (with flipped GD-32 Bluepill devboards)._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1_rev2021.5-comparison-mx-choc.JPG" width=600 />

_Height comparison between low-profile build (with Choc switches) and with sandwich-case._

<img src="https://github.com/rgoulter/keyboard-labs/blob/master/docs/images/photo-keyboard-x-1-mx-tented.JPG" width=600 />

_Tented._

<img src="https://github.com/rgoulter/keyboard-labs/blob/master/docs/images/photo-keyboard-x-1-underside.JPG" width=600 />

_Showing the underside of the PCB through the acrylic bottom layer._

<img src="https://github.com/rgoulter/keyboard-labs/raw/master/docs/images/keyboard-100x100-minif4-dual-rgb-reversible-2021.5-top.svg" width=280 />
<img src="https://github.com/rgoulter/keyboard-labs/raw/master/docs/images/keyboard-100x100-minif4-dual-rgb-reversible-2021.5-bottom.svg" width=280 />

_2D Renders of the PCB, revision rev2021.5_

Design goals:

- PCB smaller than 100x100 mm2,
  so that it's cheaper to fabricate at various
  PCB fabricators.
- Reversible PCB (use the same PCB for left/right halves).
- Using the WeAct Studio MiniF4 "black pill" dev board,
  a cheap STM32F4 dev board that runs ARM.
- Low profile (PCB + choc switches + bumpons).
- Column-staggered arrangement of key switches.
- Fancy features: e.g. per-key RGB LEDs, rotary encoders, OLED screen, DC vibration motors.

###### Build Guides

- [rev2021.4 Budget Build Guide](docs/buildguide_rev2021.4_budget.md)

- [rev2021.5 Interactive BOM](https://rgoulter.com/keyboard-labs/ibom-x1-minif4_36-rev2021.5.html)

- [rev2021.5 Interactive BOM, No Frills](https://rgoulter.com/keyboard-labs/ibom-x1-minif4_36-rev2021.5-basic.html)

###### Keyboard Layout

- Blank Layout at [keyboard-layout-editor.com](http://www.keyboard-layout-editor.com/##@_name=MiniF4%20%22Black%20Pill%22%2036-key%20Split%20Keyboard&notes=PCB%20available%20at%2F:%20https%2F:%2F%2F%2F%2Fgithub.com%2F%2Frgoulter%2F%2Fkeyboard-labs%2F%2F&pcb:true&css=%23keyboard-bg%20%7B%0A%20%20%20%20background-image%2F:%20url(%22https%2F:%2F%2F%2F%2Fraw.githubusercontent.com%2F%2Frgoulter%2F%2Fkeyboard-labs%2F%2Fmaster%2F%2Fdocs%2F%2Fimages%2F%2Fkeyboard-100x100-minif4-dual-rgb-reversible-rev2021.4-ortho-bare-sm.png%22)%2F%3B%0A%7D%3B&@_x:2&a:7%3B&=&_x:5.5%3B&=%3B&@_y:-0.95&x:3%3B&=&_x:3.5%3B&=%3B&@_y:-0.9500000000000001&x:4%3B&=%3B&@_y:-1&x:1%3B&=&_x:4.5%3B&=&_x:2%3B&=%3B&@_y:-0.6000000000000001%3B&=&_x:9.5%3B&=%3B&@_y:-0.5&x:2%3B&=&_x:5.5%3B&=%3B&@_y:-0.95&x:3%3B&=&_x:3.5%3B&=%3B&@_y:-0.9499999999999997&x:1%3B&=&_x:2%3B&=&_x:1.5%3B&=&_x:2%3B&=%3B&@_y:-0.6000000000000001%3B&=&_x:9.5%3B&=%3B&@_y:-0.5&x:2%3B&=&_x:5.5%3B&=%3B&@_y:-0.9500000000000002&x:3%3B&=&_x:3.5%3B&=%3B&@_y:-0.9499999999999997&x:1%3B&=&_x:2%3B&=&_x:1.5%3B&=&_x:2%3B&=%3B&@_y:-0.6000000000000001%3B&=&_x:9.5%3B&=%3B&@_y:-0.4500000000000002&x:2.2%3B&=&_x:5.1000000000000005%3B&=%3B&@_y:-0.5499999999999998&x:3.2%3B&=&_x:3.0999999999999996%3B&=%3B&@_y:-0.5&x:4.2%3B&=&_x:1.0999999999999996%3B&=).

- Default Layout at <a href="http://www.keyboard-layout-editor.com/##@_backcolor=%23ffffff&name=MiniF4%20%22Black%20Pill%22%2036-key%20Split%20Keyboard,%20Dvorak%2F%2FMiryoku-ish&notes=PCB%20available%20at%2F:%20https%2F:%2F%2F%2F%2Fgithub.com%2F%2Frgoulter%2F%2Fkeyboard-labs%2F%2F&pcb:true&css=%23keyboard-bg%20%7B%0A%20%20%20%20background-image%2F:%20url(%22https%2F:%2F%2F%2F%2Fraw.githubusercontent.com%2F%2Frgoulter%2F%2Fkeyboard-labs%2F%2Fmaster%2F%2Fdocs%2F%2Fimages%2F%2Fkeyboard-100x100-minif4-dual-rgb-reversible-rev2021.4-ortho-bare-sm.png%22)%2F%3B%0A%7D%3B&@_x:2&c=%239e9e9e&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff%3B&=.%0AF8%0A*%0A8&_x:5.5&t=%23000000%0A%23ff00ff&f2:1%3B&=C%0AR.HI%3B&@_y:-0.95&x:3&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=P%0AF9%0A(%0A9&_x:3.5&t=%23000000%0A%23ff00ff&f:3%3B&=G%0AR.Tog%3B&@_y:-0.95&x:1&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=,%0AF7%0A%2F&%0A7&_x:2&t=%23000000%0A%0A%2300ff00%0A%230000ff&f:3%3B&=Y%0A%0A%7B%0A%5D&_x:1.5&t=%23000000%0A%23ff00ff&f:3%3B&=F%0AR.Tog&_x:2&f:3%3B&=R%0AR.SI%3B&@_y:-0.6&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=%22%0AF12%0A%7B%0A%5B&_x:9.5&t=%23000000%0A%23ff00ff&f:3%3B&=L%0AR.VI%3B&@_y:-0.5&x:2&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=E%0AF5%0A%25%0A5%0ACtrl&_x:5.5&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%2300ffff&fa@:0&:2&:2&:2&:1%3B%3B&=T%0A%3Ci%20class%2F='kb%20kb-Multimedia-Volume-Up-1'%3E%3C%2F%2Fi%3E%0A%2F&uarr%2F%3B%0A%2F&uarr%2F%3B%0ACtrl%3B&@_y:-0.95&x:3&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=U%0AF6%0A%5E%0A6%0AShift&_x:3.5&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%2300ffff&f:3%3B&=H%0A%3Ci%20class%2F='kb%20kb-Multimedia-Volume-Down-2'%3E%3C%2F%2Fi%3E%0A%2F&darr%2F%3B%0A%2F&darr%2F%3B%0AShift%3B&@_y:-0.95&x:1&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=O%0AF4%0A$%0A4%0AGUI&_x:2&t=%23000000%0A%0A%2300ff00%0A%230000ff&f:3%3B&=I%0A%0A+%0A%2F=&_x:1.5&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%2300ffff&f:3%3B&=D%0A%3Ci%20class%2F='kb%20kb-Multimedia-Rewind-Start'%3E%3C%2F%2Fi%3E%0A%2F&larr%2F%3B%0A%2F&larr%2F%3B&_x:2&f:3%3B&=N%0A%3Ci%20class%2F='kb%20kb-Multimedia-FastForward-End'%3E%3C%2F%2Fi%3E%0A%2F&rarr%2F%3B%0A%2F&rarr%2F%3B%0AGUI%3B&@_y:-0.6000000000000001&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=A%0AF11%0A~%0A%60%0AAlt&_x:9.5&t=%23000000&f:3%3B&=S%0A%0A%0A%0AAlt%3B&@_y:-0.5&x:2&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=C%0AF2%0A%2F@%0A2&_x:5.5&t=%23000000%0A%0A%23ffff00%0A%2300ffff&fa@:0&:2&:0&:1%3B%3B&=W%0A%0A%2F&uArr%2F%3B%0APgup%3B&@_y:-0.9499999999999997&x:3&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=J%0AF3%0A%23%0A3&_x:3.5&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%2300ffff&fa@:0&:1&:0&:1%3B%3B&=M%0ADV.%0A%2F&dArr%2F%3B%0APgdn%3B&@_y:-0.9500000000000002&x:1&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=X%0AF1%0A!%0A1&_x:2&t=%23000000%0A%0A%2300ff00%0A%230000ff&f:3%3B&=K%0A%0A%3F%0A%5C&_x:1.5&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%2300ffff&f:3%3B&=B%0AQW.%0A%2F&lArr%2F%3B%0AHome&_x:2&t=%23000000%0A%0A%23ffff00%0A%2300ffff&f:3%3B&=V%0A%0A%2F&rArr%2F%3B%0AEnd%3B&@_y:-0.6000000000000001&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=%2F%3B%0AF10%0A%3F%0A%2F%2F&_x:9.5&t=%23000000%0A%0A%0A%2300ffff&f:3%3B&=Z%0A%0A%0AIns%3B&@_y:-0.4500000000000002&x:2.2&t=%23000000%0A%0A%2300ff00%0A%230000ff%0A%23ffff00&f:2%3B&=Tab%0A%0A(%0A.%0AMouse&_x:5.1000000000000005&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%0A%23ff0000%3B&=Del%0A%3Ci%20class%2F='kb%20kb-Multimedia-Mute-1'%3E%3C%2F%2Fi%3E%0AM3%0A%0AFn%3B&@_y:-0.5499999999999998&x:3.2&t=%23000000%0A%0A%2300ff00%0A%230000ff%0A%23ff00ff%3B&=Esc%0A%0A)%0A0%0AMedia&_x:3.1000000000000005&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%0A%2300ff00%3B&=Ent%0A%3Ci%20class%2F='kb%20kb-Multimedia-Stop'%3E%3C%2F%2Fi%3E%0AM2%0A%0ASym%3B&@_y:-0.5&x:4.2&t=%23000000%0A%0A%2300ff00%0A%230000ff%0A%2300ffff%3B&=Spc%0A%0A%2F_%0A-%0ANav&_x:1.1000000000000005&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%0A%230000ff%3B&=Bksp%0A%3Ci%20class%2F='kb%20kb-Multimedia-Play-Pause'%3E%3C%2F%2Fi%3E%0AM1%0A%0ANum">keyboard-layout-editor.com</a>.

###### Typing Demonstration Videos

typings.gg:

[![](https://img.youtube.com/vi/g7Msizi1cJ4/0.jpg)](https://www.youtube.com/watch?v=g7Msizi1cJ4)

typing.io:

[![](https://img.youtube.com/vi/Bn727EBErZ0/0.jpg)](https://www.youtube.com/watch?v=Bn727EBErZ0)

#### X-2: 5x12 Ortholinear, ARM-powered Adaptation of peej's Lumberjack PCB

peej's [lumberjack-keyboard](https://github.com/peej/lumberjack-keyboard) is a cool and creative
design, which continues the style of "show the components" used by keyboards like
the [plaid](https://github.com/hsgw/plaid).

One downside to it is that DIP microcontrollers are pretty weak.
Developer boards are a spiritual-successor to DIP microcontrollers,
so I wanted to adapt the striking Lumberjack design to a more
powerful developer board.

Design goals:

- Using STM32 dev board. (ARM-powered!).
- Adapt the Lumberjack design.
  - In a "show the components" style.
  - Fits in tray-mount GH60 case.
  - (Relatively) easy to solder.

Pictures:

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-2_rev2021.1-mx-top.JPG" width=600 />

_X-2 PCB assembled, using a Bluepill devboard, with MX switches, in a cheap GH-60 case._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-2_rev2021.1-choc-top.JPG" width=600 />

_X-2 PCB assembled, using a WeAct Studio MiniF4 "Blackpill" devboard, with Choc switches, in a layered acrylic case._

<img src="https://github.com/rgoulter/keyboard-labs/raw/master/docs/images/keyboard-x2-lumberjack-arm-rev2021.1-top.svg" width=600 /> <img src="https://github.com/rgoulter/keyboard-labs/raw/master/docs/images/keyboard-x2-lumberjack-arm-rev2021.1-bottom.svg" width=600 />

_2D Renders of the PCB, revision rev2021.5_

###### Build Guides

- [rev2021.1 Interactive BOM](https://rgoulter.com/keyboard-labs/ibom-x2-lumberjack-arm-revrev2021.1.html)

## CAD Designs

CAD design files found under `cad/`:

#### Tenting Stand

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboard_100x100_minif4-36key_rev2021.1mx-pair_tented.JPG"  width=600 />

`keyboard_tenting_stand.scad` describes a design which can be laser cut
and assembled to form a adjustable tenting stand. The stand can be adjusted
using an extra wedge piece.

The design accepts various parameters (e.g. width, height, angle, screw diameter).

#### Layered Case

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/openscad-layered_tray_mount_case.png" width=600 />

An OpenSCAD module which helps for modelling the layers for a layered acrylic case.

## Firmware

Source files under `firmware`.

There is keyboard firmware written in Rust using the [keyberon](https://github.com/TeXitoi/keyberon)
firmware.

## Scripts

### Kicad PCB to OpenSCAD

My attempt at generating top/bottom plate CAD files *as code*.

The script generates an OpenSCAD file with the `.kicad_pcb` data
(Kicad module positions, board outline as an OpenSCAD module, etc.), which can be used by other OpenSCAD
code.

See: [scripts/README.MD](https://github.com/rgoulter/keyboard-labs/tree/master/scripts#transform-kicad_pcb-to-scad)

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/openscad_plates-variety.png" width=600 />

_Example output of OpenSCAD code, which makes use of the Kicad PCB data to construct a variety of keyboard plates._

## Notes

- [docs/pcb-rivets.md](https://github.com/rgoulter/keyboard-labs/blob/master/docs/pcb-rivets.md):
  notes on usage of PCB rivets for allowing hot-swapping switches on
  PCBs with regular footprints.

- [docs/socketing-devboards.md](https://github.com/rgoulter/keyboard-labs/blob/master/docs/socketing-devboards.md):
  some comparison photos of some different ways of socketing
  devboards.

- [docs/rgb-leds-logic-level-shifting.md](https://github.com/rgoulter/keyboard-labs/blob/master/docs/rgb-leds-logic-level-shifting.md):
  some notes on logic level shifting.

- [docs/stm32-flashing-and-bootloaders.md](https://github.com/rgoulter/keyboard-labs/blob/master/docs/stm32-flashing-and-bootloaders.md):
  some notes on bootloaders for STM32.
