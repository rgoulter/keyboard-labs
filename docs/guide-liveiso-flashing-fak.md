My experience trying out the CH552 on Windows (e.g. with the [CH552-48 keyboard](https://github.com/rgoulter/keyboard-labs#ch552-48-low-budget-pcba-in-bm40jj40-form-factor)) was that the bootloader doesn't work well with Windows' USB. (Device manager shows the device fails to connect).

For users with only a Windows computer, it's going to be much easier to flash fak firmware from Linux. Setting up a Linux installation alongside Windows is not trivial. An easier option is to run Linux from a bootable USB drive, and use this to flash fak firmware.

To follow the steps in this guide, you need:

- Two USB thumb drives.
  - One for booting the ISO.
  - One for storing your `fak/` firmware keymap.

1. First, download an ISO for the Live USB.

   e.g. the `keyboard-labs-offline.iso` here comes with the dependencies already installed, as well as with VSCode with Nickel syntax highlighting already set up:
   https://github.com/rgoulter/keyboard-labs/releases/tag/iso-linux-environment

2. [Create a bootable USB from the ISO](https://duckduckgo.com/?q=write+iso+to+bootable+usb&t=ffab&ia=web).

   I used [Ventoy](https://www.ventoy.net/en/doc_start.html). Ventoy installs itself as a bootable USB to a thumbdrive, and then whatever ISOs you want can be copied to it, and you can then boot to those ISOs.

3. On another thumbdrive, clone or otherwise copy `fak`.

   e.g. firmware for the CH552-48 can be found in [rgoulter's fork of fak](https://github.com/rgoulter/fak).
   e.g. click "<> Code", then "Download ZIP", and unzip this into the thumbdrive.

   We're using a different thumbdrive from the one for booting the ISO so that we can save the changes we make between boots.

3. Boot into the bootable USB.  
   With the USB plugged in, open the boot menu, and select the bootable USB from earlier. (On my computer, I hit F2 and/or Del).

4. Using the ISO downloaded from the above link, you should eventually see the Gnome desktop:

   <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/linux/00-liveiso.png" />

5. Open VSCode, and then open the `fak/` directory in the other thumbdrive.

   <img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/linux/01-vscode.png" />

   In order to get syntax highlighting for the `.ncl` files, VS Code requires you to "trust" the workspace.

6. Edit the fak keyboard/keymap. Open `keymap.ncl` and `keyboard.ncl` in the `ncl/` directory.

7. Compile and Flash the firmware from the terminal.

   e.g. in VS Code, select "Terminal" -> "New Terminal".

   Then run:

   ```
   python fak.py compile
   ```

   and if that succeeds, run:

   ```
   python fak.py flash
   ```

   and put the CH552 keyboard in bootloader mode:

   - on keyboards with Fak firmware, by tapping the `tap.custom.fak.BOOT` key.

   - on the CH552-44: by holding down the P36 button when connecting the keyboard.

   - on the CH552-48: by holding shorting the `FLASH` pads when connecting the keyboard.
