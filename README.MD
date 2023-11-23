# Keyboard Labs

This repository contains the source files for keyboard
designs and keyboard firmware.

# Keyboards

Kicad source files are in `pcb`.

Plotted gerber files can be found under the GitHub repository's
[releases](https://github.com/rgoulter/keyboard-labs/releases/).

| Designation  | Summary/Keywords                                                                       | Image                                                                                                                                                 |
|--------------|----------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| [X-1](https://github.com/rgoulter/keyboard-labs#x-1-36-key-split-reversible-pcb-with-weact-studio-mini-f4-dev-board) | 36-key (2x3x5+3), split, column-staggered, MX/choc, sub-100x100, per-key RGB LED, ARM       | ![](https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1_rev2021.5-mx-top.JPG)                              |
| [X-2](#x-2-5x12-ortholinear-arm-powered-adaptation-of-peejs-lumberjack-pcb)          | 60-key (5x12), un-split, ortholinear, MX/choc, GH60-compatible, "show the components", ARM  | ![](https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-2_rev2021.1-mx-top.JPG)                              |
| [X-2 HSRGB](#x-2-hsrgb-5x12-ortholinear-arm-powered-adaptation-of-peejs-lumberjack-pcb-with-hotswap-and-per-key-rgb)    | 60-key (5x12), un-split, ortholinear, MX/choc, GH60-compatible, "show the components", HotSwap, per-key RGB, ARM  | ![](https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-2-hsrgb_rev2022.1-front.JPG)   |
| [PyKey40 Lite](#pykey40-lite-no-frills-subset-of-the-pykey60-in-bm40jj40-form-factor) | Planck-MIT (4x12, 1x2U), ortholinear, MX, BM40/JJ40-compatible, PCBA, no frills, ARM        |                                                                                                                                                       |
| [Pico42](#pico42-simple-hand-solderable-pcb-in-bm40jj40-form-factor) | 42-key ortholinear, MX/choc, BM40/JJ40-compatible, no frills, ARM        | ![](https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/pico42-mx_lowprofile_case.JPG) |
| [CH552-44](#ch552-44-low-budget-hand-solderable-pcb-in-bm40jj40-form-factor) | 44-key ortholinear, MX, BM40/JJ40-compatible, no frills        | ![](https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-44/ch552_44-sandwich-top.JPG) |
| [CH552-48](#ch552-48-low-budget-pcba-in-bm40jj40-form-factor) | 48-key ortholinear (4x12), MX, BM40/JJ40-compatible, no frills        | ![](https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48/ch552-48-top.JPG) |



## X-1: 36-key, split, reversible PCB with WeAct Studio Mini F4 dev board

Design goals:

- PCB smaller than 100x100 mm2, so that it's cheaper to fabricate at various PCB
  fabricators.
- Reversible PCB (use the same PCB for left/right halves).
- Using the WeAct Studio MiniF4 "black pill" dev board, a cheap STM32F4 dev
  board that runs ARM.
- Low profile (PCB + choc switches + bumpons).
- Column-staggered arrangement of key switches.
- Fancy features: e.g. per-key RGB LEDs, rotary encoders, OLED screen, DC vibration motors.

Pictures:

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1_rev2021.5-mx-top.JPG" width=600 />

_X-1, rev2021.5, MX variation (with rotary encoder, OLED, etc.)._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1_rev2021.5-choc-top.JPG" width=600 />

_X-1, rev2021.5, Choc variation, low-profile (with flipped GD-32 Bluepill devboards)._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1_rev2021.5-comparison-mx-choc.JPG" width=600 />

_Height comparison between low-profile build (with Choc switches) and with sandwich-case._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1-mx-tented.JPG" width=600 />

_Tented._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1-underside.JPG" width=600 />

_Showing the underside of the PCB through the acrylic bottom layer._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboard-100x100-minif4-dual-rgb-reversible-2021.5-top.svg" width=280 />
<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboard-100x100-minif4-dual-rgb-reversible-2021.5-bottom.svg" width=280 />

_2D Renders of the PCB, revision rev2021.5_

### Build Guides

- [rev2021.4 Budget Build Guide](docs/buildguide_rev2021.4_budget.md)

- [rev2021.5 Interactive BOM](https://rgoulter.com/keyboard-labs/ibom-keyboard-100x100-minif4-dual-rgb-reversible-rev2021.5.html)

- [rev2021.5 Interactive BOM, No Frills](https://rgoulter.com/keyboard-labs/ibom-x1-minif4_36-rev2021.5-basic.html)

### Keyboard Layout

- Blank Layout at [keyboard-layout-editor.com](http://www.keyboard-layout-editor.com/##@_name=MiniF4%20%22Black%20Pill%22%2036-key%20Split%20Keyboard&notes=PCB%20available%20at%2F:%20https%2F:%2F%2F%2F%2Fgithub.com%2F%2Frgoulter%2F%2Fkeyboard-labs%2F%2F&pcb:true&css=%23keyboard-bg%20%7B%0A%20%20%20%20background-image%2F:%20url(%22https%2F:%2F%2F%2F%2Fraw.githubusercontent.com%2F%2Frgoulter%2F%2Fkeyboard-labs%2F%2Fmaster%2F%2Fdocs%2F%2Fimages%2F%2Fkeyboard-100x100-minif4-dual-rgb-reversible-rev2021.4-ortho-bare-sm.png%22)%2F%3B%0A%7D%3B&@_x:2&a:7%3B&=&_x:5.5%3B&=%3B&@_y:-0.95&x:3%3B&=&_x:3.5%3B&=%3B&@_y:-0.9500000000000001&x:4%3B&=%3B&@_y:-1&x:1%3B&=&_x:4.5%3B&=&_x:2%3B&=%3B&@_y:-0.6000000000000001%3B&=&_x:9.5%3B&=%3B&@_y:-0.5&x:2%3B&=&_x:5.5%3B&=%3B&@_y:-0.95&x:3%3B&=&_x:3.5%3B&=%3B&@_y:-0.9499999999999997&x:1%3B&=&_x:2%3B&=&_x:1.5%3B&=&_x:2%3B&=%3B&@_y:-0.6000000000000001%3B&=&_x:9.5%3B&=%3B&@_y:-0.5&x:2%3B&=&_x:5.5%3B&=%3B&@_y:-0.9500000000000002&x:3%3B&=&_x:3.5%3B&=%3B&@_y:-0.9499999999999997&x:1%3B&=&_x:2%3B&=&_x:1.5%3B&=&_x:2%3B&=%3B&@_y:-0.6000000000000001%3B&=&_x:9.5%3B&=%3B&@_y:-0.4500000000000002&x:2.2%3B&=&_x:5.1000000000000005%3B&=%3B&@_y:-0.5499999999999998&x:3.2%3B&=&_x:3.0999999999999996%3B&=%3B&@_y:-0.5&x:4.2%3B&=&_x:1.0999999999999996%3B&=).

- Default Layout at <a href="http://www.keyboard-layout-editor.com/##@_backcolor=%23ffffff&name=MiniF4%20%22Black%20Pill%22%2036-key%20Split%20Keyboard,%20Dvorak%2F%2FMiryoku-ish&notes=PCB%20available%20at%2F:%20https%2F:%2F%2F%2F%2Fgithub.com%2F%2Frgoulter%2F%2Fkeyboard-labs%2F%2F&pcb:true&css=%23keyboard-bg%20%7B%0A%20%20%20%20background-image%2F:%20url(%22https%2F:%2F%2F%2F%2Fraw.githubusercontent.com%2F%2Frgoulter%2F%2Fkeyboard-labs%2F%2Fmaster%2F%2Fdocs%2F%2Fimages%2F%2Fkeyboard-100x100-minif4-dual-rgb-reversible-rev2021.4-ortho-bare-sm.png%22)%2F%3B%0A%7D%3B&@_x:2&c=%239e9e9e&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff%3B&=.%0AF8%0A*%0A8&_x:5.5&t=%23000000%0A%23ff00ff&f2:1%3B&=C%0AR.HI%3B&@_y:-0.95&x:3&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=P%0AF9%0A(%0A9&_x:3.5&t=%23000000%0A%23ff00ff&f:3%3B&=G%0AR.Tog%3B&@_y:-0.95&x:1&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=,%0AF7%0A%2F&%0A7&_x:2&t=%23000000%0A%0A%2300ff00%0A%230000ff&f:3%3B&=Y%0A%0A%7B%0A%5D&_x:1.5&t=%23000000%0A%23ff00ff&f:3%3B&=F%0AR.Tog&_x:2&f:3%3B&=R%0AR.SI%3B&@_y:-0.6&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=%22%0AF12%0A%7B%0A%5B&_x:9.5&t=%23000000%0A%23ff00ff&f:3%3B&=L%0AR.VI%3B&@_y:-0.5&x:2&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=E%0AF5%0A%25%0A5%0ACtrl&_x:5.5&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%2300ffff&fa@:0&:2&:2&:2&:1%3B%3B&=T%0A%3Ci%20class%2F='kb%20kb-Multimedia-Volume-Up-1'%3E%3C%2F%2Fi%3E%0A%2F&uarr%2F%3B%0A%2F&uarr%2F%3B%0ACtrl%3B&@_y:-0.95&x:3&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=U%0AF6%0A%5E%0A6%0AShift&_x:3.5&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%2300ffff&f:3%3B&=H%0A%3Ci%20class%2F='kb%20kb-Multimedia-Volume-Down-2'%3E%3C%2F%2Fi%3E%0A%2F&darr%2F%3B%0A%2F&darr%2F%3B%0AShift%3B&@_y:-0.95&x:1&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=O%0AF4%0A$%0A4%0AGUI&_x:2&t=%23000000%0A%0A%2300ff00%0A%230000ff&f:3%3B&=I%0A%0A+%0A%2F=&_x:1.5&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%2300ffff&f:3%3B&=D%0A%3Ci%20class%2F='kb%20kb-Multimedia-Rewind-Start'%3E%3C%2F%2Fi%3E%0A%2F&larr%2F%3B%0A%2F&larr%2F%3B&_x:2&f:3%3B&=N%0A%3Ci%20class%2F='kb%20kb-Multimedia-FastForward-End'%3E%3C%2F%2Fi%3E%0A%2F&rarr%2F%3B%0A%2F&rarr%2F%3B%0AGUI%3B&@_y:-0.6000000000000001&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=A%0AF11%0A~%0A%60%0AAlt&_x:9.5&t=%23000000&f:3%3B&=S%0A%0A%0A%0AAlt%3B&@_y:-0.5&x:2&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=C%0AF2%0A%2F@%0A2&_x:5.5&t=%23000000%0A%0A%23ffff00%0A%2300ffff&fa@:0&:2&:0&:1%3B%3B&=W%0A%0A%2F&uArr%2F%3B%0APgup%3B&@_y:-0.9499999999999997&x:3&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=J%0AF3%0A%23%0A3&_x:3.5&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%2300ffff&fa@:0&:1&:0&:1%3B%3B&=M%0ADV.%0A%2F&dArr%2F%3B%0APgdn%3B&@_y:-0.9500000000000002&x:1&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=X%0AF1%0A!%0A1&_x:2&t=%23000000%0A%0A%2300ff00%0A%230000ff&f:3%3B&=K%0A%0A%3F%0A%5C&_x:1.5&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%2300ffff&f:3%3B&=B%0AQW.%0A%2F&lArr%2F%3B%0AHome&_x:2&t=%23000000%0A%0A%23ffff00%0A%2300ffff&f:3%3B&=V%0A%0A%2F&rArr%2F%3B%0AEnd%3B&@_y:-0.6000000000000001&t=%23000000%0A%23ff0000%0A%2300ff00%0A%230000ff&f:3%3B&=%2F%3B%0AF10%0A%3F%0A%2F%2F&_x:9.5&t=%23000000%0A%0A%0A%2300ffff&f:3%3B&=Z%0A%0A%0AIns%3B&@_y:-0.4500000000000002&x:2.2&t=%23000000%0A%0A%2300ff00%0A%230000ff%0A%23ffff00&f:2%3B&=Tab%0A%0A(%0A.%0AMouse&_x:5.1000000000000005&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%0A%23ff0000%3B&=Del%0A%3Ci%20class%2F='kb%20kb-Multimedia-Mute-1'%3E%3C%2F%2Fi%3E%0AM3%0A%0AFn%3B&@_y:-0.5499999999999998&x:3.2&t=%23000000%0A%0A%2300ff00%0A%230000ff%0A%23ff00ff%3B&=Esc%0A%0A)%0A0%0AMedia&_x:3.1000000000000005&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%0A%2300ff00%3B&=Ent%0A%3Ci%20class%2F='kb%20kb-Multimedia-Stop'%3E%3C%2F%2Fi%3E%0AM2%0A%0ASym%3B&@_y:-0.5&x:4.2&t=%23000000%0A%0A%2300ff00%0A%230000ff%0A%2300ffff%3B&=Spc%0A%0A%2F_%0A-%0ANav&_x:1.1000000000000005&t=%23000000%0A%23ff00ff%0A%23ffff00%0A%0A%230000ff%3B&=Bksp%0A%3Ci%20class%2F='kb%20kb-Multimedia-Play-Pause'%3E%3C%2F%2Fi%3E%0AM1%0A%0ANum">keyboard-layout-editor.com</a>.

### Typing Demonstration Videos

typings.gg:

[![](https://img.youtube.com/vi/g7Msizi1cJ4/0.jpg)](https://www.youtube.com/watch?v=g7Msizi1cJ4)

typing.io:

[![](https://img.youtube.com/vi/Bn727EBErZ0/0.jpg)](https://www.youtube.com/watch?v=Bn727EBErZ0)



## X-2: 5x12 Ortholinear, ARM-powered Adaptation of peej's Lumberjack PCB

peej's [lumberjack-keyboard](https://github.com/peej/lumberjack-keyboard) is a cool and creative
design, which continues the style of "show the components" used by keyboards like
the [plaid](https://github.com/hsgw/plaid).

One downside to it is that DIP microcontrollers are relatively weak.
Development boards are a spiritual-successor to DIP microcontrollers,
so I wanted to adapt the striking Lumberjack design to a more
powerful development board.

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

_2D Renders of the PCB, revision rev2021.1_

### Build Guides

- [rev2021.1 Interactive BOM](https://rgoulter.com/keyboard-labs/ibom-keyboard-x2-lumberjack-arm-rev2022.1.html)



## X-2 HSRGB: 5x12 Ortholinear, ARM-powered Adaptation of peej's Lumberjack PCB, with HotSwap and per-key RGB

A fancier version of the X-2 above. With all the benefits of the X-2 (fits in GH-60 case, powerful microcontroller),
but with a RGB lighting, which makes the keyboard a bit fancier.

Design goals:

- Same as X-2:
  - Using STM32 dev board. (ARM-powered!).
  - Adapt the Lumberjack design.
    - In a "show the components" style.
    - Fits in tray-mount GH60 case.
    - (Relatively) easy to solder.
- Additional fancy features:
  - HotSwap: the PCB uses Kailh's MX Hotswap sockets. This allows being able to swap out which switches
    are used by the keyboard, without needing to resolder (or resort to using PCB rivets).
  - RGB lighting: the PCB allows for putting RGB lights under each key, as well as RGB underglow.

Pictures:

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-2-hsrgb_rev2022.1-front.JPG" width=600 />

_X-2 HSRGB PCB assembled, using a Bluepill devboard, with MX switches, in a cheap GH-60 case. Using MX switches with transparent housing, like Kailh's Jellyfish switches, enhances the RGB lighting._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-2-hsrgb_rev2022.1-back.JPG" width=600 />

_X-2 HSRGB PCB assembled, view of the back._

### Build Guides

- [HSRGB, rev2022.1 Interactive BOM](https://rgoulter.com/keyboard-labs/ibom-keyboard-x2-lumberjack-arm-hsrgb-rev2022.1.html)



## PyKey40 Lite: No-Frills Subset of the PyKey60 in BM40/JJ40 Form-Factor

My first PCBA design.

Takes jpconstantineau's [PyKey60](https://github.com/jpconstantineau/PyKey60),
and arranges a no-frills (no RGB, no hotswap, no speaker) subset of it to be a drop in replacement for the BM40/JJ40 PCB.

Design goals:

- As this is my first PCBA design: a simple design that works.

Pictures:

<img src="https://github.com/rgoulter/keyboard-labs/raw/master/docs/images/keyboard-pykey40-lite-2023.3-top.svg" width=600 />
<img src="https://github.com/rgoulter/keyboard-labs/raw/master/docs/images/keyboard-pykey40-lite-2023.3-bottom.svg" width=600 />

_2D Renders of the PCB, revision rev2023.3_



## Pico42: Simple Hand-Solderable PCB in BM40/JJ40 Form-Factor

A very simple, hand-solderable PCB which uses the Raspberry Pi Pico dev board.

I made this design because in my first attempt at designing a CNC case for the PyKey40,
I put the cutout for the USB connector in the wrong place.
Having a design which doesn't use a USB connector underneath the PCB works around this.

The form factor encourages the thumbs to use 2-3 keys each (and rely on the pinky fingers less).

Design goals:

- Simple, hand-solderable PCB.

- Uses Raspberry Pi Pico devboard. / Doesn't use USB connector underneath PCB.

- Same mounting holes as JJ40/BM40/PyKey40.

- Same pinout as PyKey40 (PyKey60).

Pictures:

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/pico42-mx_lowprofile_case.JPG" width=600 />

_Pico42 PCB assembled with MX switches, in a low profile aluminium case._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/pico42-mx_lowprofile_case-front.JPG" width=600 />

_Height of the Pico mounted on round-pin male headers in female headers._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/pico42-choc_sandwich.JPG" width=600 />

_Pico42 PCB assembled with Kailh Choc switches, in a sandwich case._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/pico42-sandwich_bottom.JPG" width=600 />

_Underside of the Pico42 in a sandwich style case._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/keyboard-pico42-2023.2-top.svg" width=600 />

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/keyboard-pico42-2023.2-bottom.svg" width=600 />

_2D Renders of the PCB, revision rev2023.2_

### Build Guides

- [rev2023.1 Interactive BOM](https://rgoulter.com/keyboard-labs/ibom-keyboard-pico42-rev2023.1.html)

- [rev2023.1 Build Guide Notes](docs/buildguide-keyboard_pico42-rev2023.1.md)



## CH552-44: Low-Budget Hand-Solderable PCB in BM40/JJ40 Form-Factor

A very simple, hand-solderable 44-key PCB which uses the WeAct Studio's CH552
devboard.

The form factor encourages the thumbs to use 2-3 keys each (and rely on the
pinky fingers less).

The keyboard uses semickolon's [fak](https://github.com/semickolon/fak)
firmware, which uses the sophisticated and modern
[Nickel](https://nickel-lang.org/) configuration language to declare keyboard
and keymap definitions.

The CH552 is cheaper than the RP2040, although is much less powerful. e.g.
you're probably not going to get Vial on a CH552 keyboard. In practice, fak
seems well suited for small-keyboard enthusiasts.

Since the CH552 has relatively few GPIO pins, the matrix uses 7 rows of 7
columns (= 14 GPIO pins), rather than a more traditional 4 rows of 12 columns
(which would use 16 GPIO pins).

Design goals:

- Low Budget.

- Simple, hand-solderable PCB.

- Uses [WeAct Studio's CH552 core board](https://www.aliexpress.com/item/1005004141926425.html).

- Same mounting holes as JJ40/BM40/PyKey40.

Pictures:

<img
src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-44/ch552_44-sandwich-top.JPG"
width=600 />

_CH552-44 (rev2023.1) in a sandwich style case._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-44/ch552_44-sandwich-bottom.JPG" width=600 />

_Underside of the CH552-44 (rev2023.1) in a sandwich style case._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-44/keyboard-ch552-44-2023.2-top.svg" width=600 />
<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-44/keyboard-ch552-44-2023.2-bottom.svg" width=600 />

_2D Renders of the PCB, revision rev2023.2_

### Build Guides and Release Assets

- [rev2023.1a Interactive BOM](https://rgoulter.com/keyboard-labs/ibom-keyboard-ch552-44-rev2023.1a.html)

- [rev2023.1a Build Guide Notes](https://github.com/rgoulter/keyboard-labs/blob/master/docs/buildguide-keyboard_ch552-44-rev2023.1a.md)

#### Firmware

- Firmware: NCL files provided under `ncl/` at https://github.com/rgoulter/fak

(NOTE: for flashing new firmware, on Windows, the CH552 bootloader *can* connect, but most of the time the bootloader will fail to connect. It's much easier to flash firmware onto the CH552 from Linux).

#### Plates and Cases

A bottom plate can be used to protect the components underneath the PCB.

Source files for plates to cut (or cases to 3D print) can be found under `cad/` in this repository.



## CH552-48: Low-Budget PCBA in BM40/JJ40 Form-Factor

A very simple 48-key PCBA which uses the CH552 MCU.

The keyboard uses semickolon's [fak](https://github.com/semickolon/fak) firmware, which uses the sophisticated and modern [Nickel](https://nickel-lang.org/) configuration language to declare keyboard and keymap definitions.

The CH552 is cheaper than the RP2040, although is much less powerful. e.g. you're probably not going to get Vial on a CH552 keyboard. In practice, fak seems well suited for small-keyboard enthusiasts.

Since the CH552 has relatively few GPIO pins, the matrix uses 7 rows of 7
columns (= 14 GPIO pins), rather than a more traditional 4 rows of 12 columns
(which would use 16 GPIO pins).

Design goals:

- PCBA and Ortho 4x12 improvement upon the [CH552-44](https://github.com/rgoulter/keyboard-labs#ch552-44-low-budget-hand-solderable-pcb-in-bm40jj40-form-factor).

- Low Budget.

- Use CH552 for the fak firmware.

- Same mounting holes as JJ40/BM40/PyKey40.

Pictures:

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48/ch552-48-top.JPG" width=600 />

_CH552-48 in a sandwich style case._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48/ch552-48-bottom.JPG" width=600 />

_Underside of the CH552-48 in a sandwich style case._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48/ch552-48-bottom-unplated.JPG" width=600 />

_Underside of the CH552-48, showing the PCBA components.._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48/keyboard-ch552-48-2023.1-top.svg" width=600 />
<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48/keyboard-ch552-48-2023.1-bottom.svg" width=600 />

_2D Renders of the PCB, revision rev2023.1_

#### Firmware

- Firmware: NCL files provided under `ncl/` at https://github.com/rgoulter/fak

(NOTE: for flashing new firmware, on Windows, the CH552 bootloader *can* connect, but most of the time the bootloader will fail to connect. It's much easier to flash firmware onto the CH552 from Linux).

#### Plates and Cases

A bottom plate can be used to protect the components underneath the PCB.

Source files for plates to cut (or cases to 3D print) can be found under `cad/` in this repository.



# CAD Designs

CAD design files found under `cad/`:

## Tenting Stand

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboard_100x100_minif4-36key_rev2021.1mx-pair_tented.JPG"  width=600 />

`keyboard_tenting_stand.scad` describes a design which can be laser cut
and assembled to form a adjustable tenting stand. The stand can be adjusted
using an extra wedge piece.

The design accepts various parameters (e.g. width, height, angle, screw diameter).

## Layered Case

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/openscad-layered_tray_mount_case.png" width=600 />

An OpenSCAD module which helps for modelling the layers for a layered acrylic case.

## Simple 3D Parameterised Case for CNC/3DP

A set of OpenScad files for a parameterised simple keyboard case design.

I've used outputs from these for CNC milling, as well as for 3D printing.

The case has several parameters, so it should be suitable for a variety of rectangular-shaped PCB keyboards.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/cad/keyboard_case/cnc-pykey40-pico42.JPG" width=600 />

_The CNC case, mounting a Pico42._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/cad/keyboard_case/cnc-pykey40-top.JPG" width=600 />

_The CNC case, top._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/cad/keyboard_case/cnc-pykey40-bottom.JPG" width=600 />

_The CNC case, bottom._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/cad/keyboard_case/3dp-pico42-choc-laptop.JPG" width=600 />

_The 3D Printed Pico42 case, mounting a Pico42 with Choc switches, sitting on a laptop's keyboard._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/cad/keyboard_case/3dp-pico42-empty-top.JPG" width=600 />

_The 3D Printed Pico42 case, top._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/cad/keyboard_case/3dp-pico42-choc-bottom.JPG" width=600 />

_The 3D Printed Pico42 case, bottom._

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/openscad-keyboard_case.png" width=600 />

_Preview of the case in OpenScad._

# Firmware

Source files under `firmware`.

[QMK](https://qmk.fm/) is the most practical firmware I've used for small
keyboards.  I maintain firmware for my keyboards and my layouts in a [downstream
GitHub
repository](https://github.com/rgoulter/qmk_firmware/tree/rgoulter-keyboards-and-layouts)
on the branch `rgoulter-keyboards-and-layouts`. (This branch will get rebased
onto qmk's `develop` branch from time to time). My code will get synced into the `firmware/qmk` directories.

There is some code for the CircuitPy keyboard firmware
[KMK](https://github.com/KMKfw/kmk_firmware).  (Although, at the time of
writing, KMK doesn't handle home row modifiers well, so IMO it's less suitable for
small keyboards as-is).

There is also keyboard firmware written in Rust using the [keyberon](https://github.com/TeXitoi/keyberon)
firmware under `firmware/keyberon`.



# Scripts

# Kicad PCB to OpenSCAD

My attempt at generating top/bottom plate CAD files *as code*.

The script generates an OpenSCAD file with the `.kicad_pcb` data
(Kicad module positions, board outline as an OpenSCAD module, etc.), which can be used by other OpenSCAD
code.

See: [scripts/README.MD](https://github.com/rgoulter/keyboard-labs/tree/master/scripts#transform-kicad_pcb-to-scad)

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/openscad_plates-variety.png" width=600 />

_Example output of OpenSCAD code, which makes use of the Kicad PCB data to construct a variety of keyboard plates._



# Notes

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

- [cad/docs/freecad-techdraw-threads.md](https://github.com/rgoulter/keyboard-labs/blob/master/cad/docs/freecad-techdraw-threads.md):
  notes on how to use FreeCad to create a technical drawing to indicate location of threads to be tapped, or where inserts are to be placed.
