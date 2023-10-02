// Constants used across OpenScad files
// for JJ40/BM40, PyKey40,
// for the switch plate(s) and bottom plate(s).
//
// Variables in CAPS are used in other files.

// Measurement of interior of low profile anodyzed aluminium case:
case_inner_width = 231;
case_inner_height = 78;
case_inner_dim = [case_inner_width, case_inner_height];

// Measured from BM40 PCB
pcb_height = 75;
pcb_width = 227;
PCB_DIM = [pcb_width, pcb_height];

// measured
// relative to PCB origin (top-left of PCB)
SW_1_1_OFFSET = [7.5, 8.5];

// measured from BM40 PCB
PCB_MOUNTING_HOLE_POSITIONS = [[17, 18], [208, 18], [208, 56], [17, 56], [112, 37]];
PCB_MOUNTING_HOLE_DIA = 2.2;

SWITCH_GRID_UNIT = 19.05;

switch_grid_cols = 12;
switch_grid_rows = 4;
switch_grid_dim = [switch_grid_cols, switch_grid_rows];

CORNER_R = 2.25;

FOOT_DIA = 22;
FOOT_HOLE_DIA = 4.1;

// plate cutout
SW_CUTOUT_HALFWIDTH = 7;

// margin between the pcb's left edge, and the left hand edge of switch cutout
sw_1_1_pcb_margin = SW_1_1_OFFSET - [SW_CUTOUT_HALFWIDTH, SW_CUTOUT_HALFWIDTH];

// c.f. case_inner_width; 0.5 smaller
switch_plate_width = 230.5;
switch_plate_height = 77.5;
SWITCH_PLATE_DIM = [switch_plate_width, switch_plate_height];

// Middle of the grid of switches on the PCB
// relative to pcb origin (top-left).
pcb_switch_grid_center = SW_1_1_OFFSET + ((switch_grid_dim - [1, 1]) / 2) * SWITCH_GRID_UNIT;

// Middle of the switch plate
// relative to switch plate origin (top-left).
plate_switch_grid_center = SWITCH_PLATE_DIM / 2;

// Hence, the switch plate's origin relative to the PCB's origin
SWITCH_PLATE_OFFSET = pcb_switch_grid_center - plate_switch_grid_center;

echo("switch plate offset", SWITCH_PLATE_OFFSET);

// margin between the pcb's right edge, and the right hand edge of switch cutout
// (used for assertions)
sw_12_4_pcb_margin_width = PCB_DIM[0] - sw_1_1_pcb_margin[0] - (12 - 1) * SWITCH_GRID_UNIT - 2 * SW_CUTOUT_HALFWIDTH;
sw_12_4_pcb_margin_height = PCB_DIM[1] - sw_1_1_pcb_margin[1] - (4 - 1) * SWITCH_GRID_UNIT - 2 * SW_CUTOUT_HALFWIDTH;

// The 'extra' dimensions of the switch plate, relative to the PCB
// (used for assertions)
lhs_extra = -SWITCH_PLATE_OFFSET[0];
top_extra = -SWITCH_PLATE_OFFSET[1];
rhs_extra = SWITCH_PLATE_DIM[0] - PCB_DIM[0] - lhs_extra;
btm_extra = SWITCH_PLATE_DIM[1] - PCB_DIM[1] - top_extra;

// The dimensions of the switch plate's edges
// (distance between the edge of the case, and switch cutout).
// (used for assertions)
plate_lhs_edge = lhs_extra + sw_1_1_pcb_margin[0];
plate_top_edge = top_extra + sw_1_1_pcb_margin[1];
plate_rhs_edge = rhs_extra + sw_12_4_pcb_margin_width;
plate_btm_edge = btm_extra + sw_12_4_pcb_margin_height;

echo("switch plate extra: left:", lhs_extra, "right:", rhs_extra);
echo("switch plate extra: top:", top_extra, "bottom:", btm_extra);

echo("switch plate edges: left:", plate_lhs_edge, "right:", plate_rhs_edge);
echo("switch plate edges: top:", plate_top_edge, "bottom:", plate_btm_edge);

assert(SWITCH_PLATE_DIM[0] < case_inner_dim[0], "inner width");
assert(SWITCH_PLATE_DIM[1] < case_inner_dim[1], "inner height");
assert(plate_lhs_edge == plate_rhs_edge);
assert(plate_top_edge == plate_btm_edge);
