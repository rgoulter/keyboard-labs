// Bottom plate aligned with the switch plate.

// Measurement of interior of anodyzed aluminium case:
//   - Case inner width 231
//   - Case inner height is 78

// PyKey40 pcb dimnsions
pcb_height = 75;
pcb_width = 227;
pcb_dim = [pcb_width, pcb_height];

switch_grid_cols = 12;
switch_grid_rows = 4;
switch_grid_dim = [switch_grid_cols, switch_grid_rows];

// relative to PCB origin
sw_1_1_offset = [7.5, 8.5];

sw_cutout_halfwidth = 7;

sw_offset = 19.05;

// margin between the pcb's left edge, and the left hand edge of switch cutout
sw_1_1_pcb_margin = sw_1_1_offset - [sw_cutout_halfwidth, sw_cutout_halfwidth];

// margin between the pcb's right edge, and the right hand edge of switch cutout
sw_12_4_pcb_margin_width = pcb_dim[0] - sw_1_1_pcb_margin[0] - (12 - 1) * sw_offset - 2 * sw_cutout_halfwidth;
sw_12_4_pcb_margin_height = pcb_dim[1] - sw_1_1_pcb_margin[1] - (4 - 1) * sw_offset - 2 * sw_cutout_halfwidth;

case_inner_width = 231;
case_inner_height = 78;
case_inner_dim = [case_inner_width, case_inner_height];

switch_plate_width = 230.5;
switch_plate_height = 77.5;
switch_plate_dim = [switch_plate_width, switch_plate_height];

corner_r = 2.25;

foot_dia = 22;
foot_hole_dia = 4.1;

// relative to pcb
pcb_switch_grid_center = sw_1_1_offset + ((switch_grid_dim - [1, 1]) / 2) * sw_offset;
// relative to switch plate
plate_switch_grid_center = switch_plate_dim / 2;

switch_plate_offset = pcb_switch_grid_center - plate_switch_grid_center;

echo("switch plate offset", switch_plate_offset);

lhs_extra = -switch_plate_offset[0];
top_extra = -switch_plate_offset[1];
rhs_extra = switch_plate_dim[0] - pcb_dim[0] - lhs_extra;
btm_extra = switch_plate_dim[1] - pcb_dim[1] - top_extra;

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

module corner(r) {
    difference() {
        square(r, center = false);
        translate([r, r]) {
            circle(r);
        }
    }
}

module switch_cutout(w = 1) {
    translate([-sw_cutout_halfwidth, -sw_cutout_halfwidth]) {
        square([
            2 * sw_cutout_halfwidth + (w - 1) * sw_offset,
            2 * sw_cutout_halfwidth
        ]);
    }
}

$fn = 60;

module square_with_rounded_corners(dim, r) {
    difference() {
        square(dim, center = false);

        translate([0, 0]) {
            rotate(0) {
                corner(r);
            }
        }
        translate([dim[0], 0]) {
            rotate(90) {
                corner(r);
            }
        }
        translate(dim) {
            rotate(180) {
                corner(r);
            }
        }
        translate([0, dim[1]]) {
            rotate(270) {
                corner(r);
            }
        }
    }
}

module jj40_bottom_plate() {
    difference() {
        translate(switch_plate_offset) {
            square_with_rounded_corners(switch_plate_dim, r = corner_r);
        }

        // D=2.2
        // 17, 18
        // 208, 18
        // 208, 56
        // 17, 56
        // 112, 37
        for (pt = [[17, 18], [208, 18], [208, 56], [17, 56], [112, 37]]) {
            translate(pt) {
                circle(d = 2.2);
            }
        }

        foot_offset_x = 32;
        foot_offset_y = 12;
        translate([0 + foot_offset_x, foot_offset_y]) {
            %circle(d = foot_dia);
            circle(d = foot_hole_dia);
        }
        translate([switch_plate_width - foot_offset_x, foot_offset_y]) {
            %circle(d = foot_dia);
            circle(d = foot_hole_dia);
        }
    }
}

scale([1, -1, 1]) {
    jj40_bottom_plate();
}
