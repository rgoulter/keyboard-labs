{
      tag = "pico42-rev2023.1",
      title = "Pico42: Simple Hand-Solderable PCB in BM40/JJ40 Form-Factor, rev 2023.1",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/pico42-mx_lowprofile_case.JPG", caption = "Pico42 MX low-profile case" },
      intro = m%"
    42-key ortholinear, MX/Choc, BM40/JJ40-compatible, no frills, ARM  -  Pico dev board.

    A very simple, hand-solderable PCB which uses the Raspberry Pi Pico dev board.

I made this design because in my first attempt at designing a CNC case for the PyKey40,
I put the cutout for the USB connector in the wrong place.
Having a design which doesn't use a USB connector underneath the PCB works around this.
  "%,
      photos = [
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/pico42-mx_lowprofile_case-front.JPG", caption = "Pico42 MX Lowprofile Case Front" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/pico42-choc_sandwich.JPG", caption = "Pico42 Choc Sandwich" },
        { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/keyboards/pico42/pico42-sandwich_bottom.JPG", caption = "Pico42 Sandwich Bottom" },
      ],
      design_goals = [
        "Simple, hand-solderable PCB.",
        "Uses Raspberry Pi Pico devboard (no USB underneath).",
        "Same mounting holes as JJ40/BM40/PyKey40.",
        "Same pinout as PyKey40 (PyKey60).",
      ],
      board = ["keyboard-pico42"],
      rev = "2023.1",
      mcu = "RP2040",
      form_factor = "JJ40",
      gerber = ["keyboard-pico42-gerber_zip.zip"],
      schematic = ["keyboard-pico42-schematic.pdf"],
      plates = [
        "jj40_bottom_plate.dxf",
        "jj40_bottom_plate.svg",
        "jj40_bottom_plate_pcb.dxf",
        "jj40_bottom_plate_pcb.svg",
        "pico42_switch_plate.dxf",
        "pico42_switch_plate.svg",
      ],
      firmware_bin = [
        "rgoulter_pico42_default.uf2",
        "rgoulter_pico42_manna-harbour_miryoku.uf2",
      ],
      source_pcb = ["pcb/keyboard-pico42.kicad_pcb"],
      source_sch = ["pcb/keyboard-pico42.kicad_sch"],
      firmware_board = "keyboards/rgoulter/pico42",
      firmware_board_url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/pico42",
      firmware_repo = "https://github.com/qmk/qmk_firmware",
      firmware_fork = "https://github.com/rgoulter/qmk_firmware",
      firmware_config = "https://github.com/rgoulter/qmk_userspace",
      firmware_keymaps = [{ name = "default", url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/pico42/keymaps/default/keymap.c" }],
      ibom = [{ url = "https://rgoulter.com/keyboard-labs/ibom-keyboard-pico42-rev2023.1.html", label = "Interactive BOM" }],
      build_guide = ["https://rgoulter.com/keyboard-labs/docs/buildguide-keyboard_pico42-rev2023.1/"],
      flashing_guide = [{ label = "Flashing the firmware", url = "https://rgoulter.com/keyboard-labs/docs/rp2040-flashing-and-bootloaders/" }],
    }
