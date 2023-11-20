include <keyboard_case-constants.scad>;
include <3dp-constants.scad>;
use <keyboard_case.scad>;
use <../keyboard_plates/keyboard-pykey40/jj40_pcb_outline.scad>;
use <../keyboard_plates/keyboard-pykey40/jj40_switch_plate.scad>;

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

projection_style = 0;

proj(
    style = projection_style
) {
    simple_keyboard_case(
        case_switch_plate_margin = CASE_SWITCH_PLATE_MARGIN + 0.5,
        upper_cavity_r = 2,
        lower_cavity_r = 2,
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
                    jj40_pcb_outline();
                }
            }
            // USB cable and connector
            translate([PCB_USB_CONNECTOR_MID_X, -3, -2]) {
                // USB connector on PCB.
                if (preview_usb_connector) {
                    color("grey", 0.4) {
                        rounded_box(w = 9, l = 7, h = 4, r = 1.7);
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
                        jj40_switch_plate();
                    }
                }
            }
        }
    }
}
