// Bottom plate aligned with the PCB.
//
// This only makes sense to use in an assembly
// of the PCB which doesn't use a switch plate,
// and solders 5-pin switches onto the PCB directly.

include <jj40_constants.scad>
use <common.scad>

$fn = 60;

module jj40_bottom_plate_pcb(
    pcb_dim = pcb_dim,
    corner_r = corner_r,
    pcb_mounting_hole_positions = pcb_mounting_hole_positions,
    pcb_mounting_hole_dia = pcb_mounting_hole_dia
) {
    difference() {
        square_with_rounded_corners(dim = pcb_dim, r = corner_r)

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
        translate([pcb_dim[0] - foot_offset_x, foot_offset_y]) {
            %circle(d = foot_dia);
            circle(d = foot_hole_dia);
        }
    }
}

scale([1, -1, 1]) {
    jj40_bottom_plate_pcb();
}
