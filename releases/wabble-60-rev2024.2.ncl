{
      tag = "wabble-60-rev2024.2",
      title = "WABBLE-60: 5x12 Ortholinear, BLE, RISC-V-powered Adaptation of peej's Lumberjack PCB",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/wabble-60/wabble-60.JPG", caption = "WABBLE-60 assembled" },
      intro = m%"
    60-key (5x12), un-split, ortholinear, MX, GH60-compatible, 'show the components', BLE, RISC-V.

    A 5x12 ortholinear, BLE keyboard using the
     [WeAct BLE core board](https://aliexpress.com/item/1005004784988010.html),
     as a RISC-V adaptation of
     peej's [lumberjack-keyboard](https://github.com/peej/lumberjack-keyboard).

The PCB design resembles the Lumberjack and mounts into GH60-compatible cases,
 but uses a much more powerful MCU than the Lumberjack's 8-bit ATMega328P.
WeAct's BLE core board is significantly cheaper than the more popular
 [nice!nano](https://nicekeyboards.com/nice-nano) BLE board.

The WABBLE-60 PCB includes LiPo charging.
  "%,
      design_goals = [
        "Using WeAct BLE core board (BLE! RISC-V-powered!).",
        "Adapt the Lumberjack design in a 'show the components' style, fits in tray-mount GH60 case, and is relatively easy to solder.",
      ],
      pcb_renders = [
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/wabble-60/keyboard-wabble-60-2024.2-top.svg", caption = "WABBLE-60 2024.2 Top" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/wabble-60/keyboard-wabble-60-2024.2-bottom.svg", caption = "WABBLE-60 2024.2 Bottom" },
      ],
      board = ["keyboard-wabble-60"],
      rev = "2024.2",
      mcu = "CH58x",
      form_factor = "GH60",
      gerber = ["keyboard-wabble-60-gerber_zip.zip"],
      schematic = ["keyboard-wabble-60-schematic.pdf"],
      plates = [
        "plate-devboard_cover-wabble-60.svg",
        "plate-switch-x2_rev2021.1.svg",
      ],
      firmware_bin = [
        "firmware-wabble-60-rgoulter.hex",
      ],
      source_pcb = ["pcb/keyboard-wabble-60.kicad_pcb"],
      source_sch = ["pcb/keyboard-wabble-60.kicad_sch"],
      firmware_board = "firmware/ch58x-ble-hid-keyboard-c/ncl/boards/wabble-60.ncl",
      firmware_board_url = "https://github.com/rgoulter/smart-keymap/blob/master/firmware/ch58x-ble-hid-keyboard-c/ncl/boards/wabble-60.ncl",
      firmware_repo = "https://github.com/rgoulter/smart-keymap",
      firmware_config = "https://github.com/rgoulter/smart-keyboard-config",
      firmware_keymaps = [{ name = "rgoulter", url = "https://github.com/rgoulter/smart-keymap/blob/master/tests/ncl/keymap-60key-rgoulter/keymap.ncl" }],
      ibom = [{ url = "https://rgoulter.com/keyboard-labs/ibom-keyboard-wabble-60-rev2024.2.html", label = "Interactive BOM" }],
      build_guide = ["https://rgoulter.com/keyboard-labs/docs/buildguide_wabble-60_rev2024.2/"],
    }
