[Nix](https://nixos.org/) is a fancy package manager.

"Nix flakes" are a recent addition to Nix which improve the user
experience compared to the older channel-oriented "nix classic"
commands.

Nix flakes interact with the `flake.nix` file in the repository's root
directory.

## Basic Usage

```
nix flake show
```

shows the flake's outputs, e.g.:

```
git+file:///path/to/keyboard-labs
├───devShells
│   └───x86_64-linux
│       ├───circuitpython: development environment 'nix-shell'
│       ├───pcb: development environment 'nix-shell'
│       └───pcb-nixos: development environment 'nix-shell'
└───packages
    └───x86_64-linux
        ├───bootloader-circuitpython-jpconstantineau_pykey60: package 'circuitpython-jpconstantineau_pykey60-8.1.0'
        ├───bootloader-stm32f103-stm32duino: package 'stm32duino-df689808b6030280480c0d151ee9c552ecf6b405'
        ├───bootloader-stm32f401-tinyuf2: package 'tinyuf2-0.9.0'
        ├───bootloader-stm32f411-tinyuf2: package 'tinyuf2-0.9.0'
        ├───docker-kibot-kicad: package 'kibot.tar.gz'
        ├───gcc-arm-a-embedded: package 'gcc-arm-a-embedded-10.3-2021.07'
        └───kicad: package 'kicad-7.0.5'
```

### devShells: `kibot`

[KiBot](https://github.com/INTI-CMNB/KiBot) can be used to generate
assets for the KiCad PCBs in this project's `pcb/` directory.

With Nix installed, run:

```
nix develop .#pcb
```

This drops the shell into a bash shell which has `kibot` on the
`PATH`, which can be used with the `config.kibot.yaml` to generate
assets in `pcb/`.

It's possible to integrate this with [direnv](https://direnv.net/) and `nix-direnv`, e.g.
with an `.envrc`:

```
if ! has nix_direnv_version || ! nix_direnv_version 1.6.0; then
    source_url "https://raw.githubusercontent.com/nix-community/nix-direnv/1.6.0/direnvrc" "sha256-FqqbUyxL8MZdXe5LkMgtNo95raZFbegFpl5k2+PrCow="
fi

use flake .#pcb
```

### Packages

#### Bootloader Firmware

e.g. the firmware for circuitpython for the jpconstantineau pykey60 board can be built with:

```
nix build .#bootloader-circuitpython-jpconstantineau_pykey60
```

This builds `firmware.uf2`, and puts the result in the `result` directory:

```
$ ls ./result/
firmware.uf2
```

#### Docker images: `docker-kibot-kicad`

e.g. running:

```
nix build .#docker-kibot-kicad
docker load < ./result
```

Will build the Docker image for `richardgoulter/kibot:kicad-7`.
(`docker load` loads the `.tar.gz` so docker can use it).

An example of using the Docker image is given in
`pcb/docker-run-kibot.sh`.
