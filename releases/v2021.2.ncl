{
      tag = "v2021.2",
      title = "v2021.2",
      hero_image = { url = "https://user-images.githubusercontent.com/1450637/110578127-a815a380-8196-11eb-8fd8-3637da9a0c73.png", caption = "Photo" },
      intro = m%"
    36-key split, column-staggered, MX/Choc, sub-100x100, ARM  -  fixes LVC, footprint, artwork.

    - Fix issues from rev2021.1:
  - Add SN74LVC1T45DBV so that SK6812mini-e and SK6812
    get 5V data signal from minif4.
  - Fix schematic for pins PA2, PB9, PC15 to align with firmware for (jumped) rev2020.1 board.
- Use updated minif4 footprint.
  (i.e. without the redundant 5V/GND/3V3).
- Simplify reference designators.
  e.g. from J_r_1 to J_2, R_LED_1 to R4, etc.
- Add TP_1, TP_2 01x04 connection pins
  to breakout pins. Allows using other controller to
  test the RGB LEDs, or using the board to test other
  RGB LED strips.
- Add PCB artwork.

Kicad: update PCB for keyboard 100x100 minif4 36-key
Changelog:
- Update per the schematic:
  - e.g. fix issue from rev2021.1:
    - add LVC,
    - adjust position of top-right hole for M2 spacer.
  - add breakout pins for RGB in/out.
  - use the other 5V, 3V3, GND pins of the minif4.
- Use thinner traces for signal traces.
- Route so as to maximize the GND zone fill on back copper layer,
  try keep signal traces far apart.
  "%,
      design_goals = [
        "PCB smaller than 100x100 mm2 (cheap to fabricate).",
        "Reversible PCB (same PCB for left/right).",
        "Using WeAct MiniF4 (STM32F4, ARM).",
        "Fixes LVC, footprint, artwork  -  36-key split, column-staggered.",
      ],
      board = ["keyboard-100x100-minif4-dual-rgb-reversible"],
      rev = "1.0",
      source_pcb = ["pcb/keyboard-100x100-minif4-dual-rgb-reversible.kicad_pcb"],
      source_sch = ["pcb/keyboard-100x100-minif4-dual-rgb-reversible.kicad_sch"],
    }
