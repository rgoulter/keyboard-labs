{
      tag = "ch32x-60-improved-rev2026.1",
      title = "CH32X-60-improved: Improved 60% ANSI keyboard, rev2026.1",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-60-improved/keyboard-ch32x-60-improved-2026.1-top.jpg", caption = "CH32X-60 Improved 2026.1 Top" },
      intro = m%"
    66-key (ANSI 60% with 6 thumb keys), row-staggered, MX, GH60-compatible, PCBA, RISC-V  -  improved spacebar.

    This keyboard-labs repository is filled with ortholinear and column-staggered designs.
I think these have more coherent designs than the standard keyboard layout.
I wanted to try a design which stays similar to the standard layout, only improving *one* aspect:
replace the standard layout's unnecessarily large spacebar.

The CH32X-60-improved retains the familiarity of the ANSI 60% keyboard, but improves the design by
replacing the 6.25u spacebar with 6 keys.
  "%,
      design_goals = [
        "Improve ANSI 60% spacebar with 6 thumb keys.",
        "Retain GH60 compatibility and row-staggered familiarity.",
        "PCBA, Low Budget, RISC-V.",
      ],
      board = ["keyboard-ch32x-60-improved"],
      rev = "2026.1",
      mcu = "CH32X035C8T6",
      form_factor = "GH60",
      store_listings = [{ name = "RGoulter's Keyboard Labs on Elecrow Marketplace", url = "https://www.elecrow.com/ch32x-60-improved-ansi-keyboard-pcb.html" }],
      gerber = ["keyboard-ch32x-60-improved_2026.1_gerber.zip"],
      schematic = ["keyboard-ch32x-60-improved-schematic.pdf"],
      plates = [
        "ch32x-60-improved_switch_plate-build123d.svg",
        "ch32x-60-improved_switch_plate-openscad.svg",
      ],
      firmware_bin = [
        "firmware-ch32x_60_improved-extend.hex",
      ],
      source_pcb = ["pcb/keyboard-ch32x-60-improved.kicad_pcb"],
      pcba = [{ bom = "keyboard-ch32x-60-improved_bom_jlc.csv", cpl = "keyboard-ch32x-60-improved_cpl_jlc.csv" }],
      source_sch = ["pcb/keyboard-ch32x-60-improved.kicad_sch"],
      firmware_board = "firmware/ch32x035-usb-device-compositekm-c/ncl/boards/ch32x-60-improved.ncl",
      firmware_board_url = "https://github.com/rgoulter/smart-keymap/blob/master/firmware/ch32x035-usb-device-compositekm-c/ncl/boards/ch32x-60-improved.ncl",
      firmware_repo = "https://github.com/rgoulter/smart-keymap",
      firmware_config = "https://github.com/rgoulter/smart-keyboard-config",
      firmware_keymaps = [
        { name = "66-key ansi-fn", url = "https://github.com/rgoulter/smart-keymap/blob/master/tests/ncl/keymap-66key-ansi-fn/keymap.ncl" },
        { name = "66-key extend", url = "https://github.com/rgoulter/smart-keymap/blob/master/tests/ncl/keymap-66key-extend/keymap.ncl" },
      ],
    }
