// Bottom plate aligned with the switch plate.

include <jj40_constants.scad>
include <common.scad>

$fn = 60;

// uses PCB's origin as the origin
module jj40_bottom_plate(
    switch_plate_dim = SWITCH_PLATE_DIM,
    pcb_switch_plate_position = PCB_SWITCH_PLATE_POSITION,
    corner_r = CORNER_R,
    pcb_sw_1_1_position = PCB_SW_1_1_POSITION,
    pcb_mounting_hole_offsets = PCB_MOUNTING_HOLE_OFFSETS,
    pcb_mounting_hole_dia = PCB_MOUNTING_HOLE_DIA
) {
    difference() {
        translate(pcb_switch_plate_position) {
            square_with_rounded_corners(switch_plate_dim, r = corner_r);
        }

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
        translate(pcb_switch_plate_position) {
            translate([0 + foot_offset_x, foot_offset_y]) {
                %circle(d = FOOT_DIA);
                circle(d = FOOT_HOLE_DIA);
            }
            translate([switch_plate_dim[0] - foot_offset_x, foot_offset_y]) {
                %circle(d = FOOT_DIA);
                circle(d = FOOT_HOLE_DIA);
            }
        }
    }
}

scale([1, -1, 1]) {
    jj40_bottom_plate();
}
