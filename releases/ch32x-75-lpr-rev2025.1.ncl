{
      tag = "ch32x-75-lpr-rev2025.1",
      title = "CH32X-75-LPR: Low-Budget PCBA with Low Profile Redragon Switches",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-75-lpr/ch32x-75.JPG", caption = "CH32X-75 LPR assembled" },
      pcb_renders = [
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-75-lpr/keyboard-ch32x-75-2025.1-top.svg", caption = "CH32X-75 LPR 2025.1 Top" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch32x-75-lpr/keyboard-ch32x-75-2025.1-bottom.svg", caption = "CH32X-75 LPR 2025.1 Bottom" },
      ],
      intro = m%"
    75-key ortholinear (5x15), low-profile Redragon, no frills, RISC-V  -  CH32X PCBA.

    A 5x15 ortholinear keyboard, which uses the CH32X MCU.

The switches are Redragon's low profile switches. See notes under [CH552-48-LPR](https://github.com/rgoulter/keyboard-labs#ch552-48-lpr-low-budget-pcba-with-low-profile-redragon-switches).
  "%,
      design_goals = [
        "A keyboard that uses Redragon low profile switches.",
        "Fits in tray-mount GH60 case.",
        "PCBA, Low Budget, RISC-V.",
      ],
      board = ["keyboard-ch32x-75"],
      rev = "2025.1",
      mcu = "CH32X035C8T6",
      form_factor = "GH60",
      gerber = ["keyboard-ch32x-75-gerber_zip.zip"],
      schematic = ["keyboard-ch32x-75-schematic.pdf"],
      pcba = [{ bom = "keyboard-ch32x-75_bom_jlc.csv", cpl = "keyboard-ch32x-75_cpl_jlc_bottom_pos.csv" }],
      source_pcb = ["pcb/keyboard-ch32x-75.kicad_pcb"],
      source_sch = ["pcb/keyboard-ch32x-75.kicad_sch"],
      firmware_board = "firmware/ch32x035-usb-device-compositekm-c/ncl/boards/ch32x-75.ncl",
      firmware_board_url = "https://github.com/rgoulter/smart-keymap/blob/master/firmware/ch32x035-usb-device-compositekm-c/ncl/boards/ch32x-75.ncl",
      firmware_repo = "https://github.com/rgoulter/smart-keymap",
      firmware_config = "https://github.com/rgoulter/smart-keyboard-config",
      firmware_keymaps = [{ name = "rgoulter", url = "https://github.com/rgoulter/smart-keymap/blob/master/tests/ncl/keymap-75key-rgoulter/keymap.ncl" }],
    }
