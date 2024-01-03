// Bottom plate aligned with the switch plate.

include <jj40_constants.scad>
include <common.scad>

$fn = 60;

// uses PCB's origin as the origin
module ch552_48_lpr_bottom_plate(
    switch_plate_dim = SWITCH_PLATE_DIM,
    pcb_switch_plate_position = PCB_SWITCH_PLATE_POSITION,
    corner_r = CORNER_R,
    pcb_sw_1_1_position = PCB_SW_1_1_POSITION,
    pcb_mounting_hole_offsets = PCB_MOUNTING_HOLE_OFFSETS,
    pcb_mounting_hole_dia = PCB_MOUNTING_HOLE_DIA,
    pcb_usb_mid_x = 35.575,
    usb_cutout_width = 13,
    // CH552-48-LPR's USB is 3.5 deeper than CH552-48
    usb_cutout_length = 3.5,
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

        translate([pcb_usb_mid_x - (usb_cutout_width / 2), pcb_switch_plate_position.y]) {
            rounded_square_cutout(dim = [usb_cutout_width, usb_cutout_length], corner_r = 1);
        }
    }
}

scale([1, -1, 1]) {
    ch552_48_lpr_bottom_plate();
}
