# CNC pykey40 case — build123d port

Native [build123d](https://build123d.readthedocs.io/) port of OpenSCAD
`simple_keyboard_case` (CNC pykey40 MX defaults), aimed at STEP export without
the OpenSCAD → FreeCAD path.

## Sources of truth

- `../keyboard_case.scad` (`simple_keyboard_case`)
- `../cnc-pykey40-mx.scad`
- `../keyboard_case-constants.scad`
- `../../keyboard_plates/keyboard-pykey40/jj40_constants.scad`
- Thread dim intent: `../keyboard_case-threads.scad`, `../../docs/freecad-techdraw-threads.md`

## Coordinates

OpenSCAD wraps the solid in `scale([1,-1,1])`. This port builds with:

- front (USB) at **Y = 0**, **+Y** toward the back
- **Z = 0** at the outer bottom

Mount hole XY matches the `keyboard_case-threads.scad` chains
(24.25 / 95.25 / 95.25 and 23.95 / 19.05 / 19.05). See `HOLE_AUDIT.md`.

## Run

```bash
python3 -m venv .venv && . .venv/bin/activate
pip install 'build123d>=0.11'
python case_pykey40.py   # writes STL + STEP beside the script
```

Flags on `make_cnc_pykey40_case(...)`:

- `cutout_feet_holes`, `cutout_bumpon_guides`, `chamfer_edges` (default on)
- Pass them `False` for a clear threads drawing solid

## Status

Initial slice: case solid + hole/plate audits. TechDraw sheets (threads A4,
full multi-view, PCB overlay) lived in a Grok Bot spike and can follow in a
later PR once orthographic layout is settled.
