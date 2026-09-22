{
      tag = "pykey40-lite-rev2023.3",
      title = "PyKey40 Lite",
      intro = m%"
    Planck-MIT (4x12, 1x2U), ortholinear, MX, BM40/JJ40-compatible, PCBA, no frills, ARM.

    This is my first PCBA design.

Takes jpconstantineau's [PyKey60](https://github.com/jpconstantineau/PyKey60), and arranges a no-frills (no RGB, no hotswap, no speaker) subset of it to be a drop in replacement for the BM40/JJ40 PCB.
  "%,
      design_goals = ["Simple design that works (first PCBA)."],
      board = ["keyboard-pykey40-lite"],
      rev = "2023.3",
      mcu = "RP2040",
      form_factor = "JJ40",
      gerber = ["keyboard-pykey40-lite-gerber_zip.zip"],
      schematic = ["keyboard-pykey40-lite-schematic.pdf"],
      plates = [
        "jj40_bottom_plate.dxf",
        "jj40_bottom_plate.svg",
        "jj40_bottom_plate_pcb.dxf",
        "jj40_bottom_plate_pcb.svg",
        "jj40_switch_plate.dxf",
        "jj40_switch_plate.svg",
      ],
      source_pcb = ["pcb/keyboard-pykey40-lite.kicad_pcb"],
      pcba = [{ bom = "keyboard-pykey40-lite_bom_jlc.csv", cpl = "keyboard-pykey40-lite_cpl_jlc_bottom_pos.csv" }],
      source_sch = ["pcb/keyboard-pykey40-lite.kicad_sch"],
      firmware_board = "keyboards/rgoulter/pykey40/lite",
      firmware_board_url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/pykey40/lite",
      firmware_repo = "https://github.com/qmk/qmk_firmware",
      firmware_fork = "https://github.com/rgoulter/qmk_firmware",
      firmware_config = "https://github.com/rgoulter/qmk_userspace",
      flashing_guide = [{ label = "Flashing the firmware", url = "https://rgoulter.com/keyboard-labs/docs/rp2040-flashing-and-bootloaders/" }],
      firmware_keymaps = [{ name = "default", url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/pykey40/lite/keymaps/default/keymap.c" }],
    }
