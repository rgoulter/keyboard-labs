{
      tag = "v2021.1",
      title = "",
      hero_image = { url = "https://user-images.githubusercontent.com/1450637/108994825-d8f1d500-76ce-11eb-96e7-c0e416fc9d22.png", caption = "Photo" },
      intro = m%"36-key (2x3x5+3), split, column-staggered, MX/Choc, sub-100x100, per-key RGB LED, ARM. Sub-100x100mm 36-key split keyboard using the WeAct MiniF4. Adds MX/Choc compatibility, RGB underglow, and plate files."%,
      errata = m%"
    - The design of the circuit for the SK6812mini-e and SK6812 LEDs is invalid. i.e. the RGB LEDs don't
work. The VDD the SK6812mini-e receive is from the `3V3` pin. This is insufficient to power the RGB
LEDs. The `DIN` from `A0` has the same `3V3` voltage, and so can't reliably signal the series of RGB
LEDs.
- The location for the M2 spacer in the top-right of the PCB (top left for the reverse side) is
_slightly_ too high. It would be better if it were equidistant between the switch above/below it.
  "%,
      changelog = m%"
    #### Changes from rev2020.1

- MiniF4 footprint now uses zig-zagged column of pins.
- Changed the layout of the thumb keys.
- Switch footprint now supports both MX and Choc switches.
- Added RGB underglow.
- Added simpler PCB variations (MX-only, Choc-only, with or without RGB lighting).
- Added Kicad files for bottom plate and switch plate. Holes added in PCB to support M2 spacers and screws.
- FIX: change the switch/pin assignments per errata noted in rev2020.1. (N.B.: pin assignment
different than rev2020.1. Notably, C15 is used for SW_15 and A2 for SW_31. - This does affect e.g.
micropython repl, the pin PC15 is always low when the `mpconfigboard.h` used the RTC, as it does by
default i.e. `#define MICROPY_HW_ENABLE_RTC       (1)`).
  "%,
      photos = [
        { url = "https://user-images.githubusercontent.com/1450637/109410010-d393d380-79c9-11eb-81a8-3ec705908d77.png", caption = "Photo" },
        { url = "https://user-images.githubusercontent.com/1450637/109410019-dbec0e80-79c9-11eb-98f2-d034f54ea0a3.png", caption = "Photo" },
        { url = "https://user-images.githubusercontent.com/1450637/109410025-e3131c80-79c9-11eb-910d-59a80106bbbf.png", caption = "Photo" },
      ],
      design_goals = [
        "PCB smaller than 100x100 mm2 (cheap to fabricate).",
        "Reversible PCB (same PCB for left/right).",
        "Using WeAct MiniF4 (STM32F4, ARM).",
        "MX/Choc compatibility, RGB underglow.",
      ],
      board = ["keyboard-100x100-minif4-dual-rgb-reversible"],
      rev = "1.0",
      source_pcb = ["pcb/keyboard-100x100-minif4-dual-rgb-reversible.kicad_pcb"],
      source_sch = ["pcb/keyboard-100x100-minif4-dual-rgb-reversible.kicad_sch"],
    }
