include <keyboard_case-constants.scad>;
include <3dp-constants.scad>;
use <keyboard_case.scad>;
use <../keyboard_plates/keyboard-pykey40/pico42_pcb_outline.scad>;
use <../keyboard_plates/keyboard-pykey40/ch552-44_switch_plate.scad>;

$fn = 64;

preview_pcb = true;
preview_usb_connector = true;
preview_usb_cable = true;

preview_switch_plate = true;

pcb_thickness = 1.6;
devboard_pcb_thickness = 1;
usb_connector_height = 4;

mx_pcb_switch_plate_depth_margin = 3;
mx_switch_plate_thickness = 1.5;

ch552_44_sw_1_1_position = [7.5, 7.5];
pcb_switch_plate_position = calculate_pcb_switch_plate_position(
    pcb_sw_1_1_position = ch552_44_sw_1_1_position
);

// heights:
//   - 2mm for soldered headers
//   - 4mm for socketed round pins
//   - 9mm for socketed round pins + round male pins
devboard_mounted_height = 2; // e.g. headers

projection_style = 0;

proj(
    style = projection_style
) {
    simple_keyboard_case(
        switch_plate_pcb_position = -pcb_switch_plate_position,
        pcb_sw_1_1_position = ch552_44_sw_1_1_position,

        case_switch_plate_margin = CASE_SWITCH_PLATE_MARGIN + 0.5,
        upper_cavity_r = 2,
        lower_cavity_r = 2,
        cutout_devboard_connector_access = true,
        devboard_mounted_height = devboard_mounted_height,
        devboard_connector_access_corner_r = 1,
        usb_connector_hole_height = 8,
        usb_connector_hole_width = USB_CONNECTOR_HOLE_WIDTH_3DP,
        mount_hole_post_dia = MOUNT_HOLE_POST_DIA_3DP,
        mount_thread_hole_tapping_dia = MOUNT_THREAD_HOLE_TAPPING_DIA_3DP,
        mount_thread_hole_threaded_height = MOUNT_THREAD_HOLE_THREADED_HEIGHT_3DP,
        mount_thread_hole_threaded_extra_height = MOUNT_THREAD_HOLE_THREADED_EXTRA_HEIGHT_3DP,
        bumpon_guide_dia = BUMPON_GUIDE_DIA_3DP,
        bumpon_guide_height = BUMPON_GUIDE_HEIGHT_3DP,
        chamfer_edges = false,
        foot_hole_dia = FOOT_HOLE_DIA_3DP
    ) {
        if (preview_pcb) {
            color("black", 0.5) {
                linear_extrude(height = pcb_thickness) {
                    pico42_pcb_outline();
                }
            }
            // USB cable and connector
            translate([PCB_DIM.x / 2, 0, pcb_thickness + devboard_mounted_height + devboard_pcb_thickness + usb_connector_height / 2]) {
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
            translate([0, 0, pcb_thickness + mx_pcb_switch_plate_depth_margin]) {
                color("grey", 0.5) {
                    linear_extrude(height = mx_switch_plate_thickness) {
                        ch552_44_switch_plate(
                            pcb_switch_plate_position = pcb_switch_plate_position,
                            pcb_sw_1_1_position = ch552_44_sw_1_1_position
                        );
                    }
                }
            }
        }
    }
}
