include <keyboard_case-constants.scad>;

use <keyboard_case.scad>;
use <../keyboard_plates/keyboard-pykey40/jj40_pcb_outline.scad>;
use <../keyboard_plates/keyboard-pykey40/jj40_switch_plate.scad>;

$fn = 64;

preview_pcb = true;
preview_usb_connector = true;
preview_usb_cable = true;

preview_switch_plate = true;

pcb_thickness = 1.6;
pcb_switch_plate_depth_margin = 3;
switch_plate_thickness = 1.5;

projection_style = 0;

module proj(style = 0) {
    if (style == 1) {
        // base
        projection(cut = true) {
            translate([0, 0, -0.1]) {
                children();
            }
        }
    } else if (style == 2) {
        // pcb
        projection(cut = true) {
            translate([0, 0, -(0.1 + CASE_BOTTOM_DEPTH)]) {
                children();
            }
        }
    } else if (style == 3) {
        // pcb
        projection(cut = true) {
            translate([0, 0, -(0.1 + CASE_BOTTOM_DEPTH + CASE_LOWER_CAVITY_DEPTH)]) {
                children();
            }
        }
    } else if (style == 4) {
        // switch plate
        projection(cut = true) {
            translate([0, 0, -(0.1 + CASE_BOTTOM_DEPTH + CASE_LOWER_CAVITY_DEPTH + pcb_thickness + pcb_switch_plate_depth_margin)]) {
                children();
            }
        }
    } else {
        children();
    }
}

proj(style = projection_style) {
    simple_keyboard_case(
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
            translate([0, 0, pcb_thickness + pcb_switch_plate_depth_margin]) {
                color("grey", 0.5) {
                    linear_extrude(height = switch_plate_thickness) {
                        jj40_switch_plate();
                    }
                }
            }
        }
    }
}
