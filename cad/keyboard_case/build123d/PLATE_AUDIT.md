# Switch plate audit — CNC pykey40

Plate outline from `SWITCH_PLATE_DIM` at `PCB_SWITCH_PLATE_POSITION`
(jj40_switch_plate / case_pykey40.py).

User intent: plate extends **19.05/2 = 9.525 mm** from outer switch centres
(grid 12×4, first switch `PCB_SW_1_1`=
(7.5, 8.5)).

## Switch grid (PCB XY)

- First switch centre (col0,row0): **(7.5000, 8.5000)**
- Last switch centre (col11,row3): **(217.0500, 65.6500)**
- Span: X 209.5500 (=11×19.05), Y 57.1500 (=3×19.05)

## Plate edges (PCB XY)

- `PCB_SWITCH_PLATE_POSITION` = **(-2.975000, -1.675000)**
- `SWITCH_PLATE_DIM` = **(230.5, 77.5)**
- Plate min/max: X [-2.9750 .. 227.5250], Y [-1.6750 .. 75.8250]

## Margin: outer switch centre → plate edge

| Side | Expected (½ unit) | Got | Δ |
|------|------------------:|----:|--:|
| Left (X) | 9.5250 | 10.475000 | +0.950000 |
| Right (X) | 9.5250 | 10.475000 | +0.950000 |
| Front (Y) | 9.5250 | 10.175000 | +0.650000 |
| Back (Y) | 9.5250 | 10.175000 | +0.650000 |

## Plate size vs half-unit ideal

- Ideal dim (outer centres ±½u): **228.6000 × 76.2000**
- Actual `SWITCH_PLATE_DIM`: **230.5 × 77.5**
- Extra beyond ideal: **+1.9000 × +1.3000**

Note: actual plate is sized to sit in the case cavity (231×78 with
`CASE_SWITCH_PLATE_MARGIN=0.25`), not to a pure half-unit outline.
L/R margins are equal; F/B margins are equal (plate centred on switch grid).

## Preview placement (OpenSCAD parity)

- Z bottom of plate = PCB bottom + 1.6 + 3.0 = **10.6**
- Thickness = **1.5**
- XY: same children frame as PCB (`case_pcb_position` + plate local XY)
