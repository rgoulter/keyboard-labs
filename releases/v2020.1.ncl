{
      tag = "v2020.1",
      title = "",
      hero_image = { url = "https://user-images.githubusercontent.com/1450637/108991477-be1d6180-76ca-11eb-802f-a24a7381b769.jpg", caption = "Photo" },
      intro = m%"
    36-key (2x3x5+3), split, column-staggered, MX, sub-100x100, per-key RGB LED, ARM  -  initial reversible MiniF4 design.

    Initial release of the PCB design for this split, 36-key keyboard. A reversible, sub-100x100mm board
using the WeAct MiniF4, with per-key RGB.
  "%,
      design_goals = [
        "PCB smaller than 100x100 mm2 (cheap to fabricate).",
        "Reversible PCB (same PCB for left/right).",
        "Using WeAct MiniF4 (STM32F4, ARM).",
      ],
      board = ["keyboard-100x100-minif4-dual-rgb-reversible"],
      rev = "1.0",
      source_pcb = ["pcb/keyboard-100x100-minif4-dual-rgb-reversible.kicad_pcb"],
      source_sch = ["pcb/keyboard-100x100-minif4-dual-rgb-reversible.kicad_sch"],
    }
