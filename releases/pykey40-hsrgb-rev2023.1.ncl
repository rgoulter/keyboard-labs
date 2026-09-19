{
      tag = "pykey40-hsrgb-rev2023.1",
      title = "PyKey40 HSRGB: 4x12 Ortholinear with HotSwap and RGB in BM40/JJ40 Form-Factor",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pykey40-hsrgb/pykey40-hsrgb-top.JPG", caption = "Pykey40 HSRGB Top" },
      intro = m%"
    Planck-MIT (4x12), ortholinear, MX, BM40/JJ40-compatible, HotSwap, per-key RGB, ARM.

    A 4x12 ortholinear with hotswap sockets, and per-key RGB and underglow, using the RP2040 MCU, with
mounts compatible with the JJ40/BM40.
  "%,
      photos = [
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pykey40-hsrgb/pykey40-hsrgb-bottom.JPG", caption = "Pykey40 HSRGB Bottom" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pykey40-hsrgb/pykey40-hsrgb-bottom-diffused.JPG", caption = "Pykey40 HSRGB Bottom Diffused" },
      ],
      design_goals = [
        "Fancy features: hotswap sockets, RGB.",
        "Same mounting holes as JJ40/BM40/PyKey40.",
      ],
      board = ["keyboard-pykey40-hsrgb"],
      rev = "2023.1",
      mcu = "RP2040",
      form_factor = "JJ40",
      gerber = ["keyboard-pykey40-hsrgb-gerber_zip.zip"],
      schematic = ["keyboard-pykey40-hsrgb-schematic.pdf"],
      source_pcb = ["pcb/keyboard-pykey40-hsrgb.kicad_pcb"],
      pcba = [{ bom = "keyboard-pykey40-hsrgb_bom_jlc.csv", cpl = "keyboard-pykey40-hsrgb_cpl_jlc_bottom_pos-fixed.csv" }],
      source_sch = ["pcb/keyboard-pykey40-hsrgb.kicad_sch"],
      firmware_board = "keyboards/rgoulter/pykey40/hsrgb",
      firmware_board_url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/pykey40/hsrgb",
      firmware_repo = "https://github.com/qmk/qmk_firmware",
      firmware_fork = "https://github.com/rgoulter/qmk_firmware",
      firmware_config = "https://github.com/rgoulter/qmk_userspace",
      firmware_keymaps = [{ name = "default", url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/pykey40/hsrgb/keymaps/default/keymap.c" }],
    }
