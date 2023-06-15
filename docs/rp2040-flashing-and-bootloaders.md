One of the nice things about the RP2040 chip is that it natively supports
flashing its firmware with UF2.  This saves the trouble of having to flash a
custom bootloader onto the chip.

The RP2040 chip is also powerful enough to run Circuit Python, and thus run [KMK
firmware](https://github.com/KMKfw/kmk_firmware/)[0].  Since KMK runs using
Circuit Python, updating/changing keyboard maps written for KMK is as easy as
editing files on a USB flash drive.

# Using KMK as the Keyboard Firmware

For running KMK, the RP2040 needs to be running Circuit Python firmware for the
appropriate board. e.g. [Circuit Python for JPConstantineau's PyKey60
board](https://circuitpython.org/board/jpconstantineau_pykey60/)[1]. -- This can
be flashed to the RP2040 by making it enter its bootloader, then copying the UF2
file to the RP2040 drive.

With Circuit Python running on the RP2040, setting up KMK involves copying the
`kmk` directory from the `kmk_firmware` repository onto the device, etc., as
explained in [KMK's Getting Started
docs](https://github.com/KMKfw/kmk_firmware/blob/master/docs/en/Getting_Started.md)[3].
-- Once it has been set up, changing the keyboard's keymap involves simply
changing the `code.py` on the CIRCUITPY volume.

For convenience, you might want to use [the `BOOTLOADER`
key](https://github.com/KMKfw/kmk_firmware/blob/74677e28fac18281307d6e4436126472e956a75e/kmk/keys.py#L369)[4]
to enter the bootloader, if you want to be able to change the UF2 bootloader
frequently. (If you plan on using KMK, you probably don't).

# Using QMK as the Keyboard Firmware

When using QMK, you need to compile the firmware each time you want to change
the keymap.

The QMK documentation [has notes on flashing for the
RP2040](https://docs.qmk.fm/#/flashing?id=raspberry-pi-rp2040-uf2)[4]. e.g. You
can use its `QK_BOOT` keycode as a way of selecting a bootloader.

The QMK documentation [has notes on RP2040 specific
details](https://docs.qmk.fm/#/platformdev_rp2040), too.

# Entering Bootloader via Hardware

e.g. the PyKey40 has `BOOT` and `RST` on the PCB. To enter the bootloader, short
(e.g. with a pair of tweezers) the `BOOT` pads, and then short the `RST` pads.

# References

[0] https://github.com/KMKfw/kmk_firmware/

[1] https://circuitpython.org/board/jpconstantineau_pykey60/

[2] https://github.com/KMKfw/kmk_firmware/blob/master/docs/en/Getting_Started.md

[3] https://github.com/KMKfw/kmk_firmware/blob/74677e28fac18281307d6e4436126472e956a75e/kmk/keys.py#L369

[4] https://docs.qmk.fm/#/flashing?id=raspberry-pi-rp2040-uf2

[5] https://docs.qmk.fm/#/platformdev_rp2040
