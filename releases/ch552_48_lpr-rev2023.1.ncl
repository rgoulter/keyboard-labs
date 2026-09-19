{
      tag = "ch552_48_lpr-rev2023.1",
      title = "CH552-48-LPR: Low-Budget PCBA with Low Profile Redragon Switches",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48-lpr/ch552_48-lpr-jj40lowpro-top.JPG", caption = "CH552-48-LPR JJ40 Lowpro Top" },
      intro = m%"
    48-key ortholinear (4x12), low-profile Redragon, MX-stem, no frills  -  CH552 PCBA.

    Variation of the CH552-48 which uses Redragon low profile switches.

Redragon low profile switches are significantly cheaper than other low profile switches,
especially the popular Kailh Choc v1 switches.
  "%,
      photos = [
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48-lpr/ch552_48-lpr-sandwich-top.JPG", caption = "CH552-48-LPR Sandwich Top" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48-lpr/ch552_48-lpr-sandwich-bottom.JPG", caption = "CH552-48-LPR Sandwich Bottom" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/ch552-48-lpr/ch552_48-lpr-plateless-switches.JPG", caption = "CH552-48-LPR Plateless Switches" },
      ],
      design_goals = [
        "A keyboard that uses Redragon low profile switches (MX-stem, 3-pin, needs plate).",
        "Low Budget, PCBA.",
      ],
      board = ["keyboard-ch552-48-lpr"],
      rev = "2023.1",
      mcu = "CH552",
      form_factor = "JJ40",
      gerber = ["keyboard-ch552-48-lpr-gerber_zip.zip"],
      schematic = ["keyboard-ch552-48-lpr-schematic.pdf"],
      plates = [
        "ch552-48-lpr_bottom_plate.svg",
        "jj40_bottom_plate.svg",
        "jj40_switch_plate-ortho_4x12.svg",
      ],
      source_pcb = ["pcb/keyboard-ch552-48-lpr.kicad_pcb"],
      pcba = [{ bom = "keyboard-ch552-48-lpr_bom_jlc.csv", cpl = "keyboard-ch552-48-lpr_cpl_jlc_bottom_pos.csv" }],
      source_sch = ["pcb/keyboard-ch552-48-lpr.kicad_sch"],
      firmware_board = "ncl/keyboards/rgoulter/ch552-48/keyboard.ncl",
      firmware_board_url = "https://github.com/rgoulter/fak/blob/rgoulter-keyboards-and-layouts/ncl/keyboards/rgoulter/ch552-48/keyboard.ncl",
      firmware_repo = "https://github.com/semickolon/fak",
      firmware_fork = "https://github.com/rgoulter/fak",
      firmware_config = "https://github.com/rgoulter/fak-config",
      firmware_keymaps = [{ name = "default", url = "https://github.com/rgoulter/fak/blob/rgoulter-keyboards-and-layouts/ncl/keymaps/ch552-48/default/keymap.ncl" }],
    }
