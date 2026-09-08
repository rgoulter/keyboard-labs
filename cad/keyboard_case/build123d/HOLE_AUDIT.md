# Hole XY audit — CNC pykey40 case

Compare build123d `thread_dim_chains()` / `mount_hole_positions_case()`
against OpenSCAD `keyboard_case-threads.scad` / jj40 + case constants.

Tolerance: **0.01 mm**.

## Outer dimensions

| | OpenSCAD expected | build123d | match |
|--|--:|--:|:--:|
| W × L × H | 239 × 86 × 12 | 239.00 × 86.00 × 12.00 | YES |

## Dimension chains

OpenSCAD (`keyboard_case-threads.scad`):

- X: `x_dim_base + mount_xs[0]`, then consecutive mount X gaps
- Y: `y_dim_base + mount_ys[0]` (front→first row), then consecutive Y gaps

| Chain | OpenSCAD expected | build123d | Δ | match (≤0.01) |
|-------|------------------:|----------:|--:|:--------------:|
| `x_dim1` | 24.25 | 24.250000 | -0.000000 | YES |
| `x_dim2` | 95.25 | 95.250000 | +0.000000 | YES |
| `x_dim3` | 95.25 | 95.250000 | +0.000000 | YES |
| `y_dim1` | 23.95 | 23.950000 | -0.000000 | YES |
| `y_dim2` | 19.05 | 19.050000 | +0.000000 | YES |
| `y_dim3` | 19.05 | 19.050000 | -0.000000 | YES |

## Mount hole centres (case XY)

Origin: front-left outer corner; +Y toward back (USB at Y≈0).

| # | X | Y |
|--:|--:|--:|
| 1 | 24.250000 | 23.950000 |
| 2 | 214.750000 | 23.950000 |
| 3 | 214.750000 | 62.050000 |
| 4 | 24.250000 | 62.050000 |
| 5 | 119.500000 | 43.000000 |

## Derived intermediates

- `case_pcb_position` = `(7.224999999999994, 5.924999999999997)`
- `cavity_pcb_position` = `(3.2249999999999943, 1.9249999999999972)`
- `pcb_cavity_dim` = `(231.0, 78.0)`

- `mount_xs_case` = `[24.249999999999993, 119.5, 214.75]`
- `mount_ys_case` = `[23.949999999999996, 43.0, 62.05]`

## Result

**PASS** — X chain 24.25 / 95.25 / 95.25 and Y 23.95 / 19.05 / 19.05 match within 0.01 mm; outer 239×86×12.

Source refs:

- `case/case_pykey40.py` — `thread_dim_chains()`, `mount_hole_positions_case()`
- `keyboard_case-threads.scad` — x_dim1..3 / y_dim1..3
- `jj40_constants.scad` / `keyboard_case-constants.scad`
