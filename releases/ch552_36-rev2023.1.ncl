{
      tag = "ch552_36-rev2023.1",
      title = "CH552-36: Low-Budget 36-key Split Keyboard with SMT Components",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-36/top.JPG", caption = "CH552-36 top view" },
      intro = m%"
    36-key (2x3x5+3), split, column-staggered, MX, sub-100x100, no frills  -  CH552 SMT.

    A very simple, 36-key PCB which uses the CH552 MCU.

The design takes inspiration from [TeXitoi's keyseebee](https://github.com/TeXitoi/keyseebee).
  "%,
      photos = [
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-36/mcu.JPG", caption = "CH552-36 MCU" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-36/tented.JPG", caption = "CH552-36 tented" },
      ],
      design_goals = [
        "Low Budget.",
        "Use CH552 for fak firmware.",
        "'Show the components', 'just a keyboard' and 'only a PCB with SMD components' from KeySeeBee.",
      ],
      board = [
        "keyboard-ch552-36-lhs",
        "keyboard-ch552-36-rhs",
      ],
      rev = "2023.1",
      mcu = "CH552",
      form_factor = "split 36",
      gerber = [
        "keyboard-ch552-36-lhs-gerber_zip.zip",
        "keyboard-ch552-36-rhs-gerber_zip.zip",
      ],
      source_pcb = [
        "pcb/keyboard-ch552-36-lhs.kicad_pcb",
        "pcb/keyboard-ch552-36-rhs.kicad_pcb",
      ],
      source_sch = [
        "pcb/keyboard-ch552-36-lhs.kicad_sch",
        "pcb/keyboard-ch552-36-rhs.kicad_sch",
      ],
      firmware_board = "ncl/keyboards/rgoulter/ch552-36/keyboard.ncl",
      firmware_board_url = "https://github.com/rgoulter/fak/blob/rgoulter-keyboards-and-layouts/ncl/keyboards/rgoulter/ch552-36/keyboard.ncl",
      firmware_repo = "https://github.com/semickolon/fak",
      firmware_fork = "https://github.com/rgoulter/fak",
      firmware_config = "https://github.com/rgoulter/fak-config",
      firmware_keymaps = [{ name = "rgoulter", url = "https://github.com/rgoulter/fak/blob/rgoulter-keyboards-and-layouts/ncl/keymaps/split_3x5_3/rgoulter/keymap.ncl" }],
      ibom = [{ url = "https://rgoulter.com/keyboard-labs/ibom-keyboard-ch552-36-rev2023.1.html", label = "Interactive BOM" }],
    }
