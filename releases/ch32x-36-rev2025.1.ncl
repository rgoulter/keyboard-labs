{
      tag = "ch32x-36-rev2025.1",
      title = "CH32X-36: Low-Budget 36-key Split Keyboard with SMT Components",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-36/ch32x-36.JPG", caption = "CH32X-36 assembled" },
      pcb_renders = [
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-36/keyboard-ch32x-36-lhs-2025.1-top.svg", caption = "CH32X-36 LHS 2025.1 Top" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-36/keyboard-ch32x-36-lhs-2025.1-bottom.svg", caption = "CH32X-36 LHS 2025.1 Bottom" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-36/keyboard-ch32x-36-rhs-2025.1-top.svg", caption = "CH32X-36 RHS 2025.1 Top" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-36/keyboard-ch32x-36-rhs-2025.1-bottom.svg", caption = "CH32X-36 RHS 2025.1 Bottom" },
      ],
      intro = m%"
    36-key (2x3x5+3), split, column-staggered, MX, sub-100x100, no frills, RISC-V  -  CH32X split.

    A very simple, 36-key PCB which uses the CH32X MCU.

It's essentially a port of the [CH552-36](https://github.com/rgoulter/keyboard-labs#ch552-36-low-budget-36-key-split-keyboard-with-smt-components) for the CH32X MCU.
  "%,
      design_goals = [
        "Low Budget, split 36-key.",
        "Use CH32X (RISC-V) for smart-keymap.",
        "'Show the components', 'just a keyboard' and 'only a PCB with SMD components' from KeySeeBee.",
      ],
      board = [
        "keyboard-ch32x-36-lhs",
        "keyboard-ch32x-36-rhs",
      ],
      rev = "2025.1",
      mcu = "CH32X",
      form_factor = "split 36",
      gerber = [
        "keyboard-ch32x-36-lhs-gerber_zip.zip",
        "keyboard-ch32x-36-rhs-gerber_zip.zip",
      ],
      schematic = [
        { file = "keyboard-ch32x-36-lhs-schematic.pdf", label = "Schematic (LHS)" },
        { file = "keyboard-ch32x-36-rhs-schematic.pdf", label = "Schematic (RHS)" },
      ],
      source_pcb = [
        "pcb/keyboard-ch32x-36-lhs.kicad_pcb",
        "pcb/keyboard-ch32x-36-rhs.kicad_pcb",
      ],
      pcba = [
        { bom = "keyboard-ch32x-36-lhs_bom_jlc.csv", cpl = "keyboard-ch32x-36-lhs_cpl_jlc_top_pos.csv" },
        { bom = "keyboard-ch32x-36-rhs_bom_jlc.csv", cpl = "keyboard-ch32x-36-rhs_cpl_jlc_top_pos.csv" },
      ],
      source_sch = [
        "pcb/keyboard-ch32x-36-lhs.kicad_sch",
        "pcb/keyboard-ch32x-36-rhs.kicad_sch",
      ],
      firmware_board = "firmware/ch32x035-usb-device-compositekm-c/ncl/boards/ch32x-36-lhs.ncl",
      firmware_board_url = "https://github.com/rgoulter/smart-keymap/blob/master/firmware/ch32x035-usb-device-compositekm-c/ncl/boards/ch32x-36-lhs.ncl",
      firmware_repo = "https://github.com/rgoulter/smart-keymap",
      firmware_config = "https://github.com/rgoulter/smart-keyboard-config",
      firmware_keymaps = [
        { name = "miryoku", url = "https://github.com/rgoulter/smart-keymap/blob/master/tests/ncl/keymap-36key-miryoku/keymap.ncl" },
        { name = "seniply", url = "https://github.com/rgoulter/smart-keymap/blob/master/tests/ncl/keymap-34key-seniply/keymap.ncl" },
        { name = "rgoulter", url = "https://github.com/rgoulter/smart-keymap/blob/master/tests/ncl/keymap-36key-rgoulter/keymap.ncl" },
      ],
      ibom = [{ url = "https://rgoulter.com/keyboard-labs/ibom-keyboard-ch32x-36-lhs-rev2025.1.html", label = "Interactive BOM" }],
    }
