"""GH60 reference dimensions.

All raw integer values are in **tenths** (0.0001 inch = 0.1 mil).

- 1 tenth = 0.0001 inch = 0.00254 mm
- 1 mil   = 0.001  inch = 0.0254  mm = 10 tenths

The GH60 reference PCB is approximately 285.0 x 94.6 mm,
 which corresponds to 112,205 x 37,244 tenths.
Hole and outline positions below
 are measured from the board origin (top-left corner) in tenths;
 ``*_MM`` values are the same positions converted to millimetres
 for use with ``pcbnew.VECTOR2I_MM``.
"""

# Conversion factor: tenths -> millimetres
TENTHS_TO_MM = 0.00254

# Board outline (tenths)
BOARD_WIDTH_TENTHS  = 112_205  # ~285.0 mm
BOARD_HEIGHT_TENTHS =  37_244  # ~94.6 mm

# Mounting holes H1-H4 (tenths, board-origin relative)
H1_X_TENTHS =  9_921
H1_Y_TENTHS = 10_984

H2_X_TENTHS = BOARD_WIDTH_TENTHS - 9_823  # mirrored from H1
H2_Y_TENTHS = 10_984

H3_X_TENTHS = 50_472
H3_Y_TENTHS = 18_504

H4_X_TENTHS = 75_000
H4_Y_TENTHS = 33_543

# Additional features (tenths, board-origin relative)
SLOTTED_HOLE_Y_TENTHS = 22_244

RESET_X_TENTHS = H1_X_TENTHS + 1_555
RESET_Y_TENTHS = H1_Y_TENTHS + 7_992

USB_X_TENTHS = H1_X_TENTHS - 2756

# Converted to millimetres (for VECTOR2I_MM)
BOARD_WIDTH_MM = BOARD_WIDTH_TENTHS * TENTHS_TO_MM
BOARD_HEIGHT_MM = BOARD_HEIGHT_TENTHS * TENTHS_TO_MM

H1_MM = (H1_X_TENTHS * TENTHS_TO_MM, H1_Y_TENTHS * TENTHS_TO_MM)
H2_MM = (H2_X_TENTHS * TENTHS_TO_MM, H2_Y_TENTHS * TENTHS_TO_MM)
H3_MM = (H3_X_TENTHS * TENTHS_TO_MM, H3_Y_TENTHS * TENTHS_TO_MM)
H4_MM = (H4_X_TENTHS * TENTHS_TO_MM, H4_Y_TENTHS * TENTHS_TO_MM)
