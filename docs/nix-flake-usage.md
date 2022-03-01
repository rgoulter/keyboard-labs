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
│       ├───kibot-kicad5: development environment 'nix-shell'
│       └───kibot-kicad6: development environment 'nix-shell'
└───packages
    └───x86_64-linux
        ├───docker-kibot-kicad-5: package 'kibot.tar.gz'
        └───docker-kibot-kicad-6: package 'kibot.tar.gz'
```

### devShells: `kibot-kicad5` and `kibot-kicad6`

[KiBot](https://github.com/INTI-CMNB/KiBot) can be used to generate
assets for the KiCad PCBs in this project's `pcb/` directory.

With Nix installed, run:

```
nix develop .#kibot-kicad5
```

This drops the shell into a bash shell which has `kibot` on the
`PATH`, which can be used with the `config.kibot.yaml` to generate
assets in `pcb/`.

It's possible to integrate this with `direnv` and `nix-direnv`, e.g.
with an `.envrc`:

```
if ! has nix_direnv_version || ! nix_direnv_version 1.6.0; then
    source_url "https://raw.githubusercontent.com/nix-community/nix-direnv/1.6.0/direnvrc" "sha256-FqqbUyxL8MZdXe5LkMgtNo95raZFbegFpl5k2+PrCow="
fi

use flake .#kibot-kicad5
```

### Packages

### Docker images: `docker-kibot-kicad-5` and `docker-kibot-kicad-6`

e.g. running:

```
nix build .#docker-kibot-kicad-5
docker load < ./result
```

Will build the Docker image for `richardgoulter/kibot:kicad-5`.
(`docker load` loads the `.tar.gz` so docker can use it).

An example of using the Docker image is given in
`pcb/docker-run-kibot.sh`.
