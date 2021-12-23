# My Experience with STM32's Native DFU Bootloader

In my experience, I have found this to be frequently unreliable and
inconsistent/indiscernable behaviour considering computer, operating
system, or particular board used.

Not even "[hold the boot button for 2
minutes](https://electronics.stackexchange.com/questions/291402/stm32f4-taking-2-minutes-to-enter-dfu)[4]"
was enough to help.

Ultimately, I think having an ST-Link device is necessary to at least
flash an easier to use bootloader onto the board.

# Bootloaders QMK Docs Recommend

In the [QMK Docs, "Using QMK" -> "Guides" -> "Flashing" -> "Flashing"](https://docs.qmk.fm/#/flashing)[0],
the following bootloaders are suggested:

- For STM32F4 (e.g. the WeAct Studio MiniF4 "Black pill" boards):

  - [Adafruit's tinyuf2](https://github.com/adafruit/tinyuf2)[1].

    - QMK will generate a `.uf2` firmware file if the `rules.mk`
      is configured correctly.

- For STM32F103 (e.g. the "blue pill" boards):

  - [rogerclarkmelbourne/STM32duino-bootloader](https://github.com/rogerclarkmelbourne/STM32duino-bootloader)[2].

    - With QMK, and the `rules.mk` set to use this bootloader, (e.g.
      as `handwired/onekey/bluepill` has by default), the complied
      `.bin` won't work if flashed to the board without this
      bootloader present. (e.g. flashing the keyboard firmware's
      `.bin` using `st-flash` is insufficient).

    - See [stm32duino's wiki page on Upload methods](https://github.com/stm32duino/wiki/wiki/Upload-methods)[3] for more details.

# References

[0] https://docs.qmk.fm/#/flashing

[1] https://github.com/adafruit/tinyuf2

[2] https://github.com/rogerclarkmelbourne/STM32duino-bootloader

[3] https://github.com/stm32duino/wiki/wiki/Upload-methods

[4] https://electronics.stackexchange.com/questions/291402/stm32f4-taking-2-minutes-to-enter-dfu
