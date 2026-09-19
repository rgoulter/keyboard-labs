{
      tag = "ch552_48-rev2023.1",
      title = "CH552-48: Low-Budget PCBA in BM40/JJ40 Form-Factor, rev2023.1",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48/ch552-48-top.JPG", caption = "CH552-48 Top" },
      intro = m%"
    48-key ortholinear (4x12), MX, BM40/JJ40-compatible, no frills  -  CH552 PCBA.

    A very simple 48-key PCBA which uses the CH552 MCU.

The keyboard uses semickolon's [fak](https://github.com/semickolon/fak) firmware, which uses the sophisticated and modern [Nickel](https://nickel-lang.org/) configuration language to declare keyboard and keymap definitions.
  "%,
      photos = [
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48/ch552-48-bottom.JPG", caption = "CH552-48 Bottom" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48/ch552-48-bottom-unplated.JPG", caption = "CH552-48 Bottom Unplated" },
      ],
      design_goals = [
        "PCBA and Ortho 4x12 improvement upon CH552-44.",
        "Low Budget.",
        "Use CH552 for fak firmware.",
        "Same mounting holes as JJ40/BM40/PyKey40.",
      ],
      board = ["keyboard-ch552-48"],
      rev = "2023.1",
      mcu = "CH552",
      form_factor = "JJ40",
      gerber = ["keyboard-ch552-48-gerber_zip.zip"],
      schematic = ["keyboard-ch552-48-schematic.pdf"],
      plates = [
        "jj40_bottom_plate.svg",
        "jj40_switch_plate-ortho_4x12.svg",
      ],
      source_pcb = ["pcb/keyboard-ch552-48.kicad_pcb"],
      pcba = [{ bom = "keyboard-ch552-48_bom_jlc.csv", cpl = "keyboard-ch552-48_cpl_jlc_bottom_pos.csv" }],
      source_sch = ["pcb/keyboard-ch552-48.kicad_sch"],
      firmware_board = "ncl/keyboards/rgoulter/ch552-48/keyboard.ncl",
      firmware_board_url = "https://github.com/rgoulter/fak/blob/rgoulter-keyboards-and-layouts/ncl/keyboards/rgoulter/ch552-48/keyboard.ncl",
      firmware_repo = "https://github.com/semickolon/fak",
      firmware_fork = "https://github.com/rgoulter/fak",
      firmware_config = "https://github.com/rgoulter/fak-config",
      firmware_keymaps = [
        { name = "default", url = "https://github.com/rgoulter/fak/blob/rgoulter-keyboards-and-layouts/ncl/keymaps/ch552-48/default/keymap.ncl" },
        { name = "rgoulter", url = "https://github.com/rgoulter/fak/blob/rgoulter-keyboards-and-layouts/ncl/keymaps/ch552-48/rgoulter/keymap.ncl" },
      ],
    }
