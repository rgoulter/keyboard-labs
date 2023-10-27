// Bottom plate aligned with the PCB.
//
// This only makes sense to use in an assembly
// of the PCB which doesn't use a switch plate,
// and solders 5-pin switches onto the PCB directly.

include <jj40_constants.scad>
use <common.scad>

$fn = 60;

module jj40_bottom_plate_pcb(
    pcb_dim = PCB_DIM,
    corner_r = CORNER_R,
    pcb_sw_1_1_position = PCB_SW_1_1_POSITION,
    pcb_mounting_hole_offsets = PCB_MOUNTING_HOLE_OFFSETS,
    pcb_mounting_hole_dia = PCB_MOUNTING_HOLE_DIA
) {
    difference() {
        square_with_rounded_corners(dim = pcb_dim, r = corner_r);

        pcb_mounting_hole_positions = [
            for (offset = pcb_mounting_hole_offsets) pcb_sw_1_1_position + offset
        ];
        for (pt = pcb_mounting_hole_positions) {
            translate(pt) {
                circle(d = pcb_mounting_hole_dia);
            }
        }

        foot_offset_x = 32;
        foot_offset_y = 12;
        translate([0 + foot_offset_x, foot_offset_y]) {
            %circle(d = FOOT_DIA);
            circle(d = FOOT_HOLE_DIA);
        }
        translate([pcb_dim[0] - foot_offset_x, foot_offset_y]) {
            %circle(d = FOOT_DIA);
            circle(d = FOOT_HOLE_DIA);
        }
    }
}

scale([1, -1, 1]) {
    jj40_bottom_plate_pcb();
}
