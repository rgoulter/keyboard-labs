{
      tag = "x1-rev2021.5",
      title = "X-1 (MiniF4-36, sub-100x100mm 36-key featureful split keyboard), rev2021.5",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1_rev2021.5-mx-top.JPG", caption = "MX Top" },
      intro = m%"
    36-key (2x3x5+3), split, column-staggered, MX/Choc, sub-100x100, per-key RGB, encoders, OLED, ARM.

    The X-1 (MiniF4-36) is a 36-key split keyboard  -  reversible, sub-100x100mm, using the WeAct MiniF4,
with per-key RGB, encoders, OLED and vibration motors.
Available in MX and Choc variants.
  "%,
      photos = [
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1_rev2021.5-choc-top.JPG", caption = "Choc Top" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1_rev2021.5-comparison-mx-choc.JPG", caption = "Comparison MX Choc" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1-mx-tented.JPG", caption = "MX Tented" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-1-underside.JPG", caption = "Underside" },
      ],
      design_goals = [
        "PCB smaller than 100x100 mm2 (cheap to fabricate).",
        "Reversible PCB (same PCB for left/right).",
        "Using WeAct MiniF4 (STM32F4, ARM).",
        "Low profile (PCB + Choc + bumpons).",
        "Column-staggered key arrangement.",
        "Fancy features: per-key RGB, encoders, OLED, vibration motors.",
      ],
      board = ["keyboard-100x100-minif4-dual-rgb-reversible"],
      rev = "2021.5",
      mcu = "STM32F4",
      form_factor = "split 36",
      gerber = ["keyboard-100x100-minif4-dual-rgb-reversible-gerber_zip.zip"],
      schematic = ["keyboard-100x100-minif4-dual-rgb-reversible-schematic.pdf"],
      plates = [
        "cover-mcu-no_buttons.dxf",
        "cover-mcu-no_buttons.svg",
        "cover-mcu.dxf",
        "cover-mcu.svg",
        "plate-bottom-with.svg",
        "plate-bottom-with_buttons_and_motor.dxf",
        "plate-bottom-with_buttons_and_motor.svg",
        "plate-bottom.dxf",
        "plate-bottom.svg",
        "plate-top.dxf",
        "plate-top.svg",
      ],
      source_pcb = ["pcb/keyboard-100x100-minif4-dual-rgb-reversible.kicad_pcb"],
      source_sch = ["pcb/keyboard-100x100-minif4-dual-rgb-reversible.kicad_sch"],
      firmware_board = "keyboards/rgoulter/minif4_36/rev2021_5",
      firmware_board_url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/minif4_36/rev2021_5",
      firmware_repo = "https://github.com/qmk/qmk_firmware",
      firmware_fork = "https://github.com/rgoulter/qmk_firmware",
      firmware_config = "https://github.com/rgoulter/qmk_userspace",
      firmware_keymaps = [{ name = "default", url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/minif4_36/keymaps/default/keymap.c" }],
      ibom = [
        { url = "https://rgoulter.com/keyboard-labs/ibom-x1-minif4_36-rev2021.5.html", label = "Interactive BOM" },
        { url = "https://rgoulter.com/keyboard-labs/ibom-x1-minif4_36-rev2021.5-basic.html", label = "Interactive BOM (Basic)" },
      ],
      build_guide = ["https://rgoulter.com/keyboard-labs/docs/buildguide_rev2021.4_budget/"],
    }
