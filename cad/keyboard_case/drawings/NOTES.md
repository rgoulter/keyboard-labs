# CNC pykey40 — build123d technical drawings

Scripts here produce SVG/PNG confidence sheets for the case solid in the parent
directory (`case_pykey40.py`). Geometry is imported from the PR tree; do not
duplicate the solid.

## Orthographic discipline

One mirrored drawing solid; cameras only differ.

- Center, then `mirror(Plane.YZ)`.
- That undoes top’s `viewport_up=(0,-1,0)` X-flip → **TOP USB top-left**.
- Same solid: **FRONT USB page-right** (Richard rule: TOP USB top-left ⇒ FRONT USB right).

| View | Camera origin | Up |
|------|---------------|-----|
| Top | `(0,0,+200)` | `(0,-1,0)` |
| Front | `(0,-200,0)` | `(0,0,+1)` |
| Side | `(+200,0,0)` | `(0,0,+1)` |

`project_to_2d` always scales with `about=(0,0,0)` after shared centering.

Dim / marker page X uses **physical** X after the YZ mirror (`origin + (x_phys - W/2)*scale`). Do **not** also remap `W - x` — that mirrors annotations away from the projected features.

## Regenerate

```bash
cd cad/keyboard_case
. ./env.sh
make case-pykey40-drawings
# or: just cad::case-pykey40-drawings
```

Individual scripts (from `drawings/`, with parent on `PYTHONPATH` via helpers):

```bash
.venv/bin/python drawings/case_pcb_drawing.py
.venv/bin/python drawings/case_z_slices_drawing.py
.venv/bin/python drawings/case_usb_section_drawing.py
.venv/bin/python drawings/case_threads_drawing.py
.venv/bin/python drawings/case_full_drawing.py
.venv/bin/python drawings/case_plate_fit_drawing.py
.venv/bin/python drawings/case_pcb_overlay.py
```

PNG via `rsvg-convert` (or `nix shell nixpkgs#librsvg -c rsvg-convert …`).

## Sheets

| Script | Output | Role |
|--------|--------|------|
| `case_pcb_drawing.py` | `cnc_pykey40_pcb_a4.*` | Standalone PCB dims / mounts / USB |
| `case_z_slices_drawing.py` | `cnc_pykey40_z_slices_a3.*` | Horizontal Z-slices |
| `case_usb_section_drawing.py` | `cnc_pykey40_usb_sections_a4.*` | USB YZ + XZ cuts |
| `case_threads_drawing.py` | `cnc_pykey40_threads_a4.*` | M2 tap locations |
| `case_full_drawing.py` | `cnc_pykey40_full_a3.*` | Full multi-view mfg |
| `case_plate_fit_drawing.py` | `cnc_pykey40_plate_fit.*` | Plate-in-cavity fit |
| `case_pcb_overlay.py` | `cnc_pykey40_pcb_overlay_*.*` | Case+PCB+plate overlay |

## Layout notes (confidence sheets)

- **PCB dims** (`case_pcb_drawing.py`): overall W/H on outer rails (large offsets);
  horizontal mount-hole chain on a separate rail *below* the PCB; vertical chain
  on the left with text outside arrows; USB mid-X / lip as one callout block
  *above* the geometry (never on dim lines).
- **Z-slices** (`case_z_slices_drawing.py`): PCB outline in red at
  `case_pcb_position` (mid-thickness slab) on every panel; USB-notch detail
  insets on bottom/lower panels.
- **USB sections** (`case_usb_section_drawing.py`): stacked SIDE (top) / FRONT
  (bottom) panels; each cut cropped to USB-pocket ROI (not full case extent).
