include <keyboard_case-constants.scad>;
include <3dp-constants.scad>;
use <keyboard_case.scad>;
use <../keyboard_plates/keyboard-pykey40/pico42_pcb_outline.scad>;
use <../keyboard_plates/keyboard-pykey40/pico42_switch_plate.scad>;

$fn = 64;

preview_pcb = true;
preview_usb_connector = true;
preview_usb_cable = true;

preview_switch_plate = true;

pcb_thickness = 1.6;
devboard_pcb_thickness = 1;
usb_connector_height = 4;

choc_pcb_switch_plate_depth_margin = 1;
choc_switch_plate_thickness = 1;

choc_cavity_upper_height = pcb_thickness + choc_pcb_switch_plate_depth_margin + choc_switch_plate_thickness;

// Without USB connector underneath the PCB,
// the lower cavity doesn't need to be 3mm+.
pico42_cavity_lower_height = 2;
pico42_case_bottom_height = 3;

pico42_rev2023_2_sw_1_1_position = [7.5, 7.5];
pcb_switch_plate_position = calculate_pcb_switch_plate_position(
    pcb_sw_1_1_position = pico42_rev2023_2_sw_1_1_position
);
// rev2023.2, with the old mounting hole values
o = [50, 50] + pico42_rev2023_2_sw_1_1_position;
lx = 67.025;
mx = 148.225;
rx = 257.525;
ty = 67.025;
my = 86.075;
by = 105.125;
pico42_rev23_2_pcb_mounting_hole_offsets = [
    [lx, ty] - o,
    [rx, ty] - o,
    [mx, my] - o,
    [lx, by] - o,
    [rx, by] - o
];

projection_style = 0;

proj(
    style = projection_style,
    cavity_upper_height = choc_cavity_upper_height,
    cavity_lower_height = pico42_cavity_lower_height,
    case_bottom_height = pico42_case_bottom_height
) {
    simple_keyboard_case(
        pcb_sw_1_1_position = pico42_rev2023_2_sw_1_1_position,
        switch_plate_pcb_position = -pcb_switch_plate_position,

        case_switch_plate_margin = CASE_SWITCH_PLATE_MARGIN + 0.5,
        pcb_mounting_hole_offsets = pico42_rev23_2_pcb_mounting_hole_offsets,
        cavity_upper_height = choc_cavity_upper_height,
        cavity_lower_height = pico42_cavity_lower_height,
        case_bottom_height = pico42_case_bottom_height,
        upper_cavity_r = 2,
        lower_cavity_r = 2,
        cutout_devboard_connector_access = true,
        devboard_mounted_height = 0,
        devboard_connector_access_corner_r = 1.5,
        usb_connector_hole_height = 8,
        mount_hole_post_dia = MOUNT_HOLE_POST_DIA_3DP,
        mount_thread_hole_tapping_dia = MOUNT_THREAD_HOLE_TAPPING_DIA_3DP,
        mount_thread_hole_threaded_height = MOUNT_THREAD_HOLE_THREADED_HEIGHT_3DP,
        mount_thread_hole_threaded_extra_height = MOUNT_THREAD_HOLE_THREADED_EXTRA_HEIGHT_3DP,
        case_bumpon_guide_positions = [[10, 10], [10, -10]],
        bumpon_guide_dia = BUMPON_GUIDE_DIA_3DP,
        bumpon_guide_height = BUMPON_GUIDE_HEIGHT_3DP,
        chamfer_edges = false,
        cutout_usb_connector = false,
        cutout_feet_holes = false
    ) {
        if (preview_pcb) {
            color("black", 0.5) {
                linear_extrude(height = pcb_thickness) {
                    pico42_pcb_outline();
                }
            }
            // USB cable and connector
            translate([PCB_DIM.x / 2, 0, pcb_thickness + devboard_pcb_thickness + usb_connector_height / 2]) {
                // USB connector on PCB.
                if (preview_usb_connector) {
                    color("grey", 0.4) {
                        rotate([0, 0, 0]) {
                            rounded_box(w = 9, l = 7, h = 4, r = 1.7);
                        }
                    }
                }
                if (preview_usb_cable) {
                    color("black", 0.6) {
                        rotate([0, 0, 180]) {
                            rounded_box(w = 12, l = 18, h = 6, r = 1);
                        }
                    }
                }
            }
        }

        if (preview_switch_plate) {
            translate([0, 0, pcb_thickness + choc_pcb_switch_plate_depth_margin]) {
                color("grey", 0.5) {
                    linear_extrude(height = choc_switch_plate_thickness) {
                        pico42_switch_plate(
                            pcb_switch_plate_position = pcb_switch_plate_position,
                            pcb_sw_1_1_position = pico42_rev2023_2_sw_1_1_position
                        );
                    }
                }
            }
        }
    }
}
