# Keyboard Labs

Build guides and shared notes for [rgoulter/keyboard-labs](https://github.com/rgoulter/keyboard-labs).

Interactive BOMs remain at the [site root](https://rgoulter.com/keyboard-labs/).

## Assembled vs source markdown

- **Assembled** (e.g. Pico42 assembled): one continuous guide for the site. Shared fragments under `docs/includes/` are pulled in with snippets, so the reader stays on one page.
- **Source markdown**: the same files as in the GitHub repo. Useful while we migrate guides to the assembled form.

## Sections

- **Build guides** — per-board guides (assembled demo + source pages)
- **Flashing** — RP2040, STM32, FAK
- **PCB Design** — e.g. RGB level shifting
- **Notes** — soldering tools, socketing, rivets

## Local preview

```bash
just docs::serve
```

Binds `0.0.0.0:8000` so other Tailscale machines can open
`http://<this-host>:8000/keyboard-labs/docs/`.
