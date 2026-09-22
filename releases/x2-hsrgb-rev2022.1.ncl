{
      tag = "x2-hsrgb-rev2022.1",
      title = " X-2 HSRGB (Lumberjack-inspired ARM, Ortholinear 5x12, HotSwap, RGB) Keyboard, rev2022.1",
      hero_image = { url = "https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/photo-keyboard-x-2-hsrgb_rev2022.1-front.JPG", caption = "HSRGB Rev2022.1 Front" },
      intro = m%"
    60-key (5x12), un-split, ortholinear, MX/Choc, GH60-compatible, 'show the components', HotSwap, per-key RGB, ARM.

    peej's [lumberjack-keyboard](https://github.com/peej/lumberjack-keyboard) is a cool and creative
design, which continues the style of 'show the components' used by keyboards like
the [plaid](https://github.com/hsgw/plaid).

One downside to it is that DIP microcontrollers aren't quite powerful enough to power every bell & whistle that QMK has to offer. Development boards are a spiritual-successor to DIP microcontrollers, so I wanted to adapt the striking Lumberjack design to a more powerful development board.
  "%,
      design_goals = [
        "Using STM32 dev board (ARM-powered!).",
        "Adapt the Lumberjack design in a 'show the components' style, fits in tray-mount GH60 case, and is relatively easy to solder.",
        "HotSwap: Kailh MX HotSwap sockets (swap switches without soldering).",
        "RGB lighting: per-key RGB and underglow.",
      ],
      board = ["keyboard-x2-lumberjack-arm-hsrgb"],
      rev = "2022.1",
      mcu = "STM32",
      form_factor = "GH60",
      gerber = ["keyboard-x2-lumberjack-arm-hsrgb-gerber_zip.zip"],
      plates = [
        "cover-mcu-blackpill.dxf",
        "cover-mcu-blackpill.svg",
        "cover-mcu-bluepill.dxf",
        "cover-mcu-bluepill.svg",
        "cover-mcu.dxf",
        "cover-mcu.svg",
        "plate-switch.dxf",
        "plate-switch.svg",
      ],
      source_pcb = ["pcb/keyboard-x2-lumberjack-arm-hsrgb.kicad_pcb"],
      source_sch = ["pcb/keyboard-x2-lumberjack-arm-hsrgb.kicad_sch"],
      firmware_board = "keyboards/rgoulter/x_2/hsrgb/rev2022_1",
      firmware_board_url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/x_2/hsrgb/rev2022_1",
      firmware_repo = "https://github.com/qmk/qmk_firmware",
      firmware_fork = "https://github.com/rgoulter/qmk_firmware",
      firmware_config = "https://github.com/rgoulter/qmk_userspace",
      flashing_guide = [{ label = "Flashing the firmware", url = "https://rgoulter.com/keyboard-labs/docs/stm32-flashing-and-bootloaders/" }],
      firmware_keymaps = [{ name = "default", url = "https://github.com/rgoulter/qmk_firmware/blob/rgoulter-keyboards-and-layouts/keyboards/rgoulter/x_2/keymaps/default/keymap.c" }],
    }
