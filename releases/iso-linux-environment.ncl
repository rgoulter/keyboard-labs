{
      tag = "iso-linux-environment",
      title = "Live ISO Linux Environment for Fak",
      intro = m%"
    Live ISO Linux environment for flashing Fak (CH552)  -  NixOS with wch-isp, sdcc.

    My experience trying out the CH552 on Windows (e.g. with the [CH552-48 keyboard](https://github.com/rgoulter/keyboard-labs#ch552-48-low-budget-pcba-in-bm40jj40-form-factor)) was that the bootloader doesn't work well with Windows' USB. (Device manager shows the device fails to connect).

This ISO is a build of NixOS Linux which includes some software for flashing firmware onto the CH552, and other useful dependencies for [semickolon's fak](https://github.com/semickolon/fak):
  "%,
      board = [],
      rev = "1.0",
      source_pcb = [],
      source_sch = [],
    }
