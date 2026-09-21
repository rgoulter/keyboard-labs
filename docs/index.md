# Keyboard Labs

Build guides and shared notes for [rgoulter/keyboard-labs](https://github.com/rgoulter/keyboard-labs).

Interactive BOMs remain at the [site root](https://rgoulter.com/keyboard-labs/).

Markdown in `docs/` stays GitHub-readable. This MkDocs site publishes those same pages with Material nav and search.

The Pico42, WABBLE-60, and CH552-44 rev2023.2 build guides assemble shared fragments from `docs/includes/` via pymdownx.snippets,
so their soldering-tools sections (and Pico42's RP2040-flashing section) share one source of truth with the Notes/Flashing pages.
GitHub blob views do not expand these includes; read those guides on this site.

## Local preview

```bash
just docs::serve
```

Binds `0.0.0.0:8000`. Open `http://<this-host>:8000/` (for example `http://gaming-pc:8000/` on the Tailscale tailnet).
