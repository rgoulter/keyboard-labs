{
      tag = "v2021.2-0303",
      title = "v2021.2 (Fab'd on 03/03)",
      intro = m%"
    36-key split, column-staggered, MX/Choc, sub-100x100, ARM  -  fab 2021-03-03.

    Design sent for fabrication on 2021-03-03, with silkscreen labeling it as 'v2021.2'.

Fabrication status: fabricated, received PCBs.
  "%,
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
