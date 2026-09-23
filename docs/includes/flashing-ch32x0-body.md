## WCH ISP Programs

### Official WCH ISP Tool

You can flash firmware onto the keyboards with the CH32X0
 using WCH's WCH ISP tool.

https://www.wch-ic.com/downloads/WCHISPTool_Setup_exe.html

### Open Source wch command line tools

There are several open source programs which can be used.

I like the Rust `wchisp` command line tool.
 (https://github.com/ch32-rs/wchisp).
Be sure to read the notes on the readme
 (e.g. installation requirements for Windows/Linux/etc.).

With `wchisp`, you enter the bootloader and then run:

```
wchisp flash <my firmware.hex>
```

## Entering the Bootloader

There are different ways to enter bootloader mode.

### Shorting BOOT/DOWNLOAD and Plugging in USB

WCH's CH32X0 MCUs have a bootloader
 which runs in bootloader mode
 when the USB is plugged in with BOOT shorted.

On the PCBs in this repository, the pads to short together
 are labelled with "BOOT".

This bootloader is read-only,
 so you will always be able to enter the bootloader
 using this method.

The steps to flash with this method are:

1. Short the BOOT pads together
   (e.g. using a paperclip or tweezers to connect the two BOOT pads together).

2. Connect the keyboard to the computer.

3. Flash the firmware using whichever WCH ISP tool you're using.

### smart-keymap Firmware: Hold Down the First Key

For keyboard firmware built with the smart-keymap firmware,
 the firmware will enter the bootloader if the key `SW_1_1`
 is held when the USB is connected.

This works if the correct keyboard firmware has been flashed.

The steps to flash with this method are:

1. With a keyboard running the smart-keymap firmware,
   hold down the switch at the top left (`SW_1_1`).

2. Connect the keyboard to the computer.

3. Flash the firmware using whichever WCH ISP tool you're using.

### smart-keymap Firmware: BOOT Key

For keyboard firmware built with the smart-keymap firmware,
 the firmware will enter the bootloader
 when the `K.BOOT`/`K.reset_to_bootloader` key is pressed.

The steps to flash with this method are:

1. With a keyboard running the smart-keymap firmware,
   and with the keyboard connected to the computer: tap the `K.BOOT` key.

2. Flash the firmware using whichever WCH ISP tool you're using.

## Help, I Bricked my Keyboard

Because the USB bootloader is in the CH32X0's ROM,
 it's practically impossible to brick the keyboard.
You'll always be able to flash new firmware by
 shorting BOOT/DOWNLOAD and plugging in USB.

