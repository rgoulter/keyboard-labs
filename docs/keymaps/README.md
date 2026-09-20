# Production keymap layouts for keyboard-labs release bodies.

Each `layouts/<name>/` holds one board keymap's visualisation sources,
mirroring the upstream demo convention (`export-legend.ncl` + `layout.rhm`),
but these are production runners: one per flashed firmware binary, with
release filenames baked in.

The viz engine stays in `smart-keymap-lib` (`tools/keymap-viz-rhombus`)
and is located purely by env var — nothing engine-side is checked in here.
Layout runners keep the upstream relative `../../src` imports; they run
out-of-tree through the upstream `viz-path` entrypoint, which assembles a
scratch tree. The `bundle` path in each `layout.rhm` follows the `viz-path`
default `out/.cache/<dir>-bundle.json`, so the recipe passes only the
layout and exporter paths.

## Layouts

| Dir | Keymap (prebuilt firmware) | Geometry |
| --- | --- | --- |
| `ch32x_48_basic` | `keymap-48key-basic` | grid 4x12 |
| `ch32x_48_rgoulter` | `keymap-48key-rgoulter` | grid 4x12 |
| `ch32x_36_rgoulter` | `keymap-36key-rgoulter` | split 3x5+3, board geometry |
| `ch32x_36_miryoku` | `keymap-36key-miryoku` | split 3x5+3, board geometry |
| `ch32x_60_improved_extend` | `keymap-66key-extend` (shipped binary) | ansi 66 |
| `ch32x_60_improved_ansi_fn` | `keymap-66key-ansi-fn` (extra) | ansi 66 |

Keymap sources resolve through `SMART_KEYMAP_ROOT` (Nickel `--import-path`,
same mechanism as upstream); the board switch-position fixtures come from
the upstream scratch tree.

## Generate

```sh
export KEYMAP_VIZ_ROOT=/path/to/smart-keymap-lib/tools/keymap-viz-rhombus
# toolchain: racket + rhombus/rhombus-json, nickel 1.14+, inkscape
# (e.g. the smart-keymap-lib devenv shell)

just releases::viz ch32x_60_improved_extend   # one layout
just releases::viz-all                        # all
```

SVG + PNG outputs land in `docs/images/keyboards/<board>/` and are checked
in; from there `releases.ncl` + `templates/release.md.j2` reference them.
Re-running must reproduce the checked-in SVGs byte-identically.

## Add a layout

Copy the closest dir, change the keymap import + source string in
`export-legend.ncl` and the PointsIR factory + emit filenames in
`layout.rhm`, keeping the `out/.cache/<dir>-bundle.json` convention.
Register the dir in the `releases::viz` mapping.
