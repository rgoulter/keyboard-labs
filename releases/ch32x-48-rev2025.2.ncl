{
      tag = "ch32x-48-rev2025.2",
      title = "CH32X-48: Low-Budget PCBA in BM40/JJ40 Form-Factor",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-48/ch32x-48.JPG", caption = "CH32X-48 assembled" },
      pcb_renders = [
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-48/keyboard-ch32x-48-2025.2-top.svg", caption = "CH32X-48 2025.2 Top" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-48/keyboard-ch32x-48-2025.2-bottom.svg", caption = "CH32X-48 2025.2 Bottom" },
      ],
      intro = m%"
    48-key ortholinear (4x12), MX, BM40/JJ40-compatible, no frills, RISC-V  -  CH32X PCBA.

    A very simple 48-key PCBA which uses the CH32X MCU.

It's essentially a port of the [CH552-48](https://github.com/rgoulter/keyboard-labs#ch552-48-low-budget-pcba-in-bm40jj40-form-factor) for the CH32X MCU.
  "%,
      design_goals = [
        "Low Budget, PCBA.",
        "Use CH32X (RISC-V) for smart-keymap.",
        "Same mounting holes as JJ40/BM40.",
      ],
      board = ["keyboard-ch32x-48"],
      rev = "2025.2",
      mcu = "CH32X035C8T6",
      form_factor = "JJ40/BM40",
      store_listings = [{ name = "RGoulter's Keyboard Labs on Elecrow Marketplace", url = "https://www.elecrow.com/ch32x-48-40-ortholinear-keyboard-pcb.html" }],
      gerber = ["keyboard-ch32x-48-gerber_zip.zip"],
      schematic = ["keyboard-ch32x-48-schematic.pdf"],
      pcba = [{ bom = "keyboard-ch32x-48_bom_jlc.csv", cpl = "keyboard-ch32x-48_cpl_jlc.csv" }],
      plates = [
        "jj40_bottom_plate.svg",
        "jj40_switch_plate-ortho_4x12.svg",
      ],
      firmware_bin = [
        "ch32x-48-rev2025.2_default.elf",
        "ch32x-48-rev2025.2_default.hex",
        "firmware-ch32x_48-rev2025_2-rgoulter.hex",
      ],
      source_pcb = ["pcb/keyboard-ch32x-48.kicad_pcb"],
      source_sch = ["pcb/keyboard-ch32x-48.kicad_sch"],
      firmware_board = "firmware/ch32x035-usb-device-compositekm-c/ncl/boards/ch32x-48/rev2025_2.ncl",
      firmware_board_url = "https://github.com/rgoulter/smart-keymap/blob/master/firmware/ch32x035-usb-device-compositekm-c/ncl/boards/ch32x-48/rev2025_2.ncl",
      firmware_repo = "https://github.com/rgoulter/smart-keymap",
      firmware_config = "https://github.com/rgoulter/smart-keyboard-config",
      firmware_keymaps = [
        { name = "48-key basic", url = "https://github.com/rgoulter/smart-keymap/blob/master/tests/ncl/keymap-48key-basic/keymap.ncl" },
        { name = "rgoulter", url = "https://github.com/rgoulter/smart-keymap/blob/master/tests/ncl/keymap-48key-rgoulter/keymap.ncl" },
      ],
      keymap_diagrams = [
        {
          keymap = "48-key basic",
          dense = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-48/ch32x-48-basic-dense.svg",
          stacked = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-48/ch32x-48-basic-stacked.svg",
        },
        {
          keymap = "rgoulter",
          dense = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-48/ch32x-48-rgoulter-dense.svg",
          stacked = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-48/ch32x-48-rgoulter-stacked.svg",
        },
      ],
    }
