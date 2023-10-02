// Measurement of interior of low profile anodyzed aluminium case:
case_inner_width = 231;
case_inner_height = 78;
case_inner_dim = [case_inner_width, case_inner_height];

// Measured from BM40 PCB
pcb_height = 75;
pcb_width = 227;
pcb_dim = [pcb_width, pcb_height];

// measured
// relative to PCB origin (top-left of PCB)
sw_1_1_offset = [7.5, 8.5];

// measured from BM40 PCB
pcb_mounting_hole_positions = [[17, 18], [208, 18], [208, 56], [17, 56], [112, 37]];
pcb_mounting_hole_dia = 2.2;

sw_offset = 19.05;

switch_grid_cols = 12;
switch_grid_rows = 4;
switch_grid_dim = [switch_grid_cols, switch_grid_rows];

corner_r = 2.25;

foot_dia = 22;
foot_hole_dia = 4.1;

// plate cutout
sw_cutout_halfwidth = 7;

// margin between the pcb's left edge, and the left hand edge of switch cutout
sw_1_1_pcb_margin = sw_1_1_offset - [sw_cutout_halfwidth, sw_cutout_halfwidth];

// margin between the pcb's right edge, and the right hand edge of switch cutout
sw_12_4_pcb_margin_width = pcb_dim[0] - sw_1_1_pcb_margin[0] - (12 - 1) * sw_offset - 2 * sw_cutout_halfwidth;
sw_12_4_pcb_margin_height = pcb_dim[1] - sw_1_1_pcb_margin[1] - (4 - 1) * sw_offset - 2 * sw_cutout_halfwidth;

// c.f. case_inner_width; 0.5 smaller
switch_plate_width = 230.5;
switch_plate_height = 77.5;
switch_plate_dim = [switch_plate_width, switch_plate_height];

// Middle of the grid of switches on the PCB
// relative to pcb origin (top-left).
pcb_switch_grid_center = sw_1_1_offset + ((switch_grid_dim - [1, 1]) / 2) * sw_offset;

// Middle of the switch plate
// relative to switch plate origin (top-left).
plate_switch_grid_center = switch_plate_dim / 2;

// Hence, the switch plate's origin relative to the PCB's origin
switch_plate_offset = pcb_switch_grid_center - plate_switch_grid_center;

echo("switch plate offset", switch_plate_offset);

// The 'extra' dimensions of the switch plate, relative to the PCB
lhs_extra = -switch_plate_offset[0];
top_extra = -switch_plate_offset[1];
rhs_extra = switch_plate_dim[0] - pcb_dim[0] - lhs_extra;
btm_extra = switch_plate_dim[1] - pcb_dim[1] - top_extra;

// The dimensions of the switch plate's edges
// (distance between the edge of the case, and switch cutout).
plate_lhs_edge = lhs_extra + sw_1_1_pcb_margin[0];
plate_top_edge = top_extra + sw_1_1_pcb_margin[1];
plate_rhs_edge = rhs_extra + sw_12_4_pcb_margin_width;
plate_btm_edge = btm_extra + sw_12_4_pcb_margin_height;

echo("switch plate extra: left:", lhs_extra, "right:", rhs_extra);
echo("switch plate extra: top:", top_extra, "bottom:", btm_extra);

echo("switch plate edges: left:", plate_lhs_edge, "right:", plate_rhs_edge);
echo("switch plate edges: top:", plate_top_edge, "bottom:", plate_btm_edge);

assert(switch_plate_dim[0] < case_inner_dim[0], "inner width");
assert(switch_plate_dim[1] < case_inner_dim[1], "inner height");
assert(plate_lhs_edge == plate_rhs_edge);
assert(plate_top_edge == plate_btm_edge);
