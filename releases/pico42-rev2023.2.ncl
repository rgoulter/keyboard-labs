{
      tag = "pico42-rev2023.2",
      title = "Pico42: Simple Hand-Solderable PCB in BM40/JJ40 Form-Factor, rev 2023.2",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/keyboard-pico42-2023.2-top.svg", caption = "Pico42 2023.2 Top" },
      intro = m%"42-key ortholinear, MX/Choc, BM40/JJ40-compatible, no frills, ARM  -  minor outline fix (see Changelog). A minor improvement over [Pico42 rev2023.1](https://github.com/rgoulter/keyboard-labs/releases/tag/pico42-rev2023.1)."%,
      changelog = m%"
    #### Improvements

  - Development Board cover plate: add mounting holes
     so a cover plate can be mounted to cover the development board area.
    Using a cover over the development board is not necessary.
  - Adding an extra mounting hole, for sandwich- or 3DP-cases.
  - Smaller, symmetrical PCB outline.
    Pico42 rev2023.1 retained the same PCB outline as BM40,
     which has extra margins around the switches to allow
     for the bigger Kailh hotswap socket footprints.
    Pico42 doesn't use hotswap sockets, so doesn't need this padding.
  "%,
      pcb_renders = [{ url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/keyboard-pico42-2023.2-bottom.svg", caption = "Pico42 2023.2 Bottom" }],
      design_goals = [
        "Simple, hand-solderable PCB.",
        "Uses Raspberry Pi Pico devboard (no USB underneath).",
        "Same mounting holes as JJ40/BM40/PyKey40.",
        "Same pinout as PyKey40 (PyKey60).",
      ],
      board = ["keyboard-pico42"],
      rev = "2023.2",
      mcu = "RP2040",
      form_factor = "JJ40",
      gerber = ["keyboard-pico42-gerber_zip.zip"],
      plates = ["plate-pico42-devboard-cover.svg"],
      build_guide = ["https://rgoulter.com/keyboard-labs/docs/buildguide-keyboard_pico42-rev2023.1/"],
      source_pcb = ["pcb/keyboard-pico42.kicad_pcb"],
      source_sch = ["pcb/keyboard-pico42.kicad_sch"],
      firmware_board = "keyboards/rgoulter/pico42",
      firmware_board_url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/pico42",
      firmware_repo = "https://github.com/qmk/qmk_firmware",
      firmware_fork = "https://github.com/rgoulter/qmk_firmware",
      firmware_config = "https://github.com/rgoulter/qmk_userspace",
      firmware_keymaps = [{ name = "default", url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/pico42/keymaps/default/keymap.c" }],
    }
