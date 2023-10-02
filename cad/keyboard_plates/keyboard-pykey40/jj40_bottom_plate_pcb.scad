// Bottom plate aligned with the PCB.
//
// This only makes sense to use in an assembly
// of the PCB which doesn't use a switch plate,
// and solders 5-pin switches onto the PCB directly.

include <jj40_constants.scad>
use <common.scad>

$fn = 60;

module jj40_bottom_plate_pcb() {
    difference() {
        union() {
            square_with_rounded_corners(dim = [pcb_width, pcb_height], r = corner_r)
            square(, center = false);
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
        translate([pcb_width - foot_offset_x, foot_offset_y]) {
            %circle(d = foot_dia);
            circle(d = foot_hole_dia);
        }
    }
}

scale([1, -1, 1]) {
    jj40_bottom_plate_pcb();
}
