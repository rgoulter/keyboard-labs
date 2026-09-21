{
      tag = "ch552_44-rev2023.2",
      title = "CH552-44: Low-Budget Hand-Solderable PCB in BM40/JJ40 Form-Factor, rev2023.2",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-44/ch552_44-sandwich-top.JPG", caption = "CH552-44 Sandwich Top" },
      intro = m%"
    44-key ortholinear, MX, BM40/JJ40-compatible, no frills  -  CH552 dev board, hand-solderable.

    A very simple, hand-solderable 44-key PCB which uses the WeAct Studio's CH552 devboard.

The form factor encourages the thumbs to use 2-3 keys each (and rely on the pinky fingers less).
  "%,
      design_goals = [
        "Low Budget.",
        "Simple, hand-solderable PCB.",
        "Uses WeAct CH552 core board.",
        "Same mounting holes as JJ40/BM40/PyKey40.",
      ],
      board = ["keyboard-ch552-44"],
      rev = "2023.2",
      mcu = "CH552",
      form_factor = "JJ40",
      gerber = ["keyboard-ch552-44-gerber_zip.zip"],
      schematic = ["keyboard-ch552-44-schematic.pdf"],
      plates = [
        "ch552-44_switch_plate.svg",
        "jj40_bottom_plate.svg",
      ],
      source_pcb = ["pcb/keyboard-ch552-44.kicad_pcb"],
      source_sch = ["pcb/keyboard-ch552-44.kicad_sch"],
      firmware_board = "ncl/keyboards/rgoulter/ch552-44/keyboard.ncl",
      firmware_board_url = "https://github.com/rgoulter/fak/blob/rgoulter-keyboards-and-layouts/ncl/keyboards/rgoulter/ch552-44/keyboard.ncl",
      firmware_repo = "https://github.com/semickolon/fak",
      firmware_fork = "https://github.com/rgoulter/fak",
      firmware_config = "https://github.com/rgoulter/fak-config",
      firmware_keymaps = [{ name = "rgoulter", url = "https://github.com/rgoulter/fak/blob/rgoulter-keyboards-and-layouts/ncl/keymaps/ch552-44/rgoulter/keymap.ncl" }],
      ibom = [{ url = "https://rgoulter.com/keyboard-labs/ibom-keyboard-ch552-44-rev2023.2.html", label = "Interactive BOM" }],
      build_guide = ["https://rgoulter.com/keyboard-labs/docs/buildguide-keyboard_ch552-44-rev2023.2/"],
    }
