// Bottom plate aligned with the switch plate.

include <jj40_constants.scad>
include <common.scad>

$fn = 60;

module jj40_bottom_plate(
    switch_plate_dim = switch_plate_dim,
    switch_plate_offset = switch_plate_offset,
    corner_r = corner_r,
    pcb_mounting_hole_positions = pcb_mounting_hole_positions,
    pcb_mounting_hole_dia = pcb_mounting_hole_dia
) {
    difference() {
        translate(switch_plate_offset) {
            square_with_rounded_corners(switch_plate_dim, r = corner_r);
        }

        for (pt = pcb_mounting_hole_positions) {
            translate(pt) {
                circle(d = pcb_mounting_hole_dia);
            }
        }

        foot_offset_x = 32;
        foot_offset_y = 12;
        translate([0 + foot_offset_x, foot_offset_y]) {
            %circle(d = foot_dia);
            circle(d = foot_hole_dia);
        }
        translate([switch_plate_dim[0] - foot_offset_x, foot_offset_y]) {
            %circle(d = foot_dia);
            circle(d = foot_hole_dia);
        }
    }
}

scale([1, -1, 1]) {
    jj40_bottom_plate();
}
