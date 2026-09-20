#!/usr/bin/env bash
# Render production keymap diagrams (docs/keymaps/layouts/*) into
# docs/images/keyboards/<board>/ as SVG + PNG.
#
# Usage: keymaps-viz.sh <layouts-dir> <images-dir> [layout ...]
#   With no layout args, renders every layouts/*/ dir.
#
# Needs KEYMAP_VIZ_ROOT (tools/keymap-viz-rhombus in a smart-keymap-lib
# checkout) plus racket/nickel/inkscape on PATH. SMART_KEYMAP_ROOT defaults
# to the smart-keymap-lib checkout root derived from KEYMAP_VIZ_ROOT.
set -euo pipefail

kb="${1:?layouts dir}"
img="${2:?images dir}"
shift 2
# Absolute: the viz tool changes cwd internally, so relative paths for the
# layout and exporter would otherwise resolve against the wrong directory.
kb="$(cd "$kb" && pwd)"
mkdir -p "$img"
img="$(cd "$img" && pwd)"

viz="${KEYMAP_VIZ_ROOT:?set KEYMAP_VIZ_ROOT to tools/keymap-viz-rhombus in a smart-keymap-lib checkout}"
[ -x "$viz/run.sh" ] || { echo "no run.sh under KEYMAP_VIZ_ROOT: $viz" >&2; exit 1; }
for bin in racket nickel inkscape; do
  command -v "$bin" >/dev/null 2>&1 || { echo "missing on PATH: $bin" >&2; exit 1; }
done
export SMART_KEYMAP_ROOT="${SMART_KEYMAP_ROOT:-$(cd "$viz/../.." && pwd)}"

dest_for() {
  case "$1" in
    ch32x_48_*) echo "$img/ch32x-48" ;;
    ch32x_36_*) echo "$img/ch32x-36" ;;
    ch32x_60_improved_*) echo "$img/ch32x-60-improved" ;;
    *) echo "unknown layout dir: $1" >&2; return 1 ;;
  esac
}

render_one() {
  local name="$1" dest scratch svg png
  dest="$(dest_for "$name")"
  mkdir -p "$dest"
  scratch="$("$viz/run.sh" viz-path "$kb/$name/layout.rhm" "$kb/$name/export-legend.ncl" | sed -n 's/^scratch: //p' | tail -n 1)"
  [ -n "$scratch" ] || { echo "viz-path printed no scratch dir for $name" >&2; exit 1; }
  for svg in "$scratch"/out/*.svg; do
    cp "$svg" "$dest/"
    png="$dest/$(basename "${svg%.svg}").png"
    inkscape --export-type=png --export-filename="$png" "$svg" > /dev/null 2>&1
    echo "wrote $dest/$(basename "$svg") + $(basename "$png")"
  done
  rm -rf "$scratch"
}

if [ "$#" -gt 0 ]; then
  for name in "$@"; do render_one "$name"; done
else
  for d in "$kb"/*/; do render_one "$(basename "$d")"; done
fi
