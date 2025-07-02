# Keyboard Labs - Dvorak Layout Edition

This repository contains the source files for keyboard designs and firmware optimized for Dvorak keyboard layouts.

## What is Dvorak?

The Dvorak keyboard layout is an ergonomic alternative to the standard QWERTY layout. Designed by August Dvorak and William Dealey in the 1930s, it places the most commonly used letters in English on the home row, reducing finger movement and potentially increasing typing speed and comfort.

## Keyboards

All keyboards in this repository support Dvorak layouts through QMK firmware. The PCB designs are in the `pcb` directory.

### Key Features

- **Ergonomic Design**: Our keyboards are designed with ergonomics in mind, complementing the Dvorak layout's focus on comfort and efficiency.
- **QMK Firmware**: All keyboards use QMK firmware with pre-configured Dvorak layouts.
- **Customizable**: Easily modify the firmware to create your own personalized Dvorak layout variations.


## Dvorak Layout Configuration

### Default Dvorak Layout

Our keyboards come with a standard Dvorak layout configuration:

```
,----------------------------------.           ,----------------------------------.
|   '   |   ,   |   .   |   P   |   Y   |           |   F   |   G   |   C   |   R   |   L   |
|-------+-------+-------+-------+-------|           |-------+-------+-------+-------+-------|
|   A   |   O   |   E   |   U   |   I   |           |   D   |   H   |   T   |   N   |   S   |
|-------+-------+-------+-------+-------|           |-------+-------+-------+-------+-------|
|   ;   |   Q   |   J   |   K   |   X   |           |   B   |   M   |   W   |   V   |   Z   |
`----------------------------------'           `----------------------------------'
                  ,-----.                                     ,-----.
                  | ESC |                                     | ENT |
            ,-----+-----+-----.                         ,-----+-----+-----.
            | TAB | SPC | BSP |                         | DEL | SPC | SFT |
            `-----------------'                         `-----------------'
```

### Programming Dvorak

For programmers, we also offer a Programming Dvorak variant that optimizes symbol placement for coding:

```
,----------------------------------.           ,----------------------------------.
|   &   |   [   |   {   |   }   |   (   |           |   =   |   *   |   )   |   +   |   ]   |
|-------+-------+-------+-------+-------|           |-------+-------+-------+-------+-------|
|   :   |   <   |   >   |   P   |   Y   |           |   F   |   G   |   C   |   R   |   L   |
|-------+-------+-------+-------+-------|           |-------+-------+-------+-------+-------|
|   A   |   O   |   E   |   U   |   I   |           |   D   |   H   |   T   |   N   |   S   |
`----------------------------------'           `----------------------------------'
                  ,-----.                                     ,-----.
                  | ESC |                                     | ENT |
            ,-----+-----+-----.                         ,-----+-----+-----.
            | TAB | SPC | BSP |                         | DEL | SPC | SFT |
            `-----------------'                         `-----------------'
```

## Firmware

The `firmware` directory contains QMK firmware configurations for all keyboards. Each keyboard has a default Dvorak layout, but you can customize it to your preferences.

### Setting Up Dvorak

1. Navigate to the firmware directory for your keyboard
2. Edit the keymap file to customize your Dvorak layout
3. Compile and flash the firmware to your keyboard

## Build Guides

See the `docs` directory for detailed build guides for each keyboard model.


## Resources

- [Learn Dvorak](https://www.dvorak-keyboard.com/)
- [Typing Practice for Dvorak](https://learn.dvorak.nl/)
- [QMK Firmware Documentation](https://docs.qmk.fm/)

## Contributing

We welcome contributions to improve our Dvorak layouts and keyboard designs. Please feel free to submit pull requests or open issues with suggestions.
