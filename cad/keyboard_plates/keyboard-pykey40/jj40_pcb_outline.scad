// definition for the PCB outline for the edge cuts layer for the PCB.

include <jj40_constants.scad>
use <common.scad>

$fn = 60;

include_usb_connector = true;

module pcb_outline_usb_connector(
) {
    extraW = 2;
    usb_conn_w = 9;
    translate([-(usb_conn_w / 2) - (extraW / 2), -2]) {
        w = usb_conn_w + extraW;
        difference() {
            square([w, 4], center = false);

            corner(r = 0.5);
            translate([w, 0]) {
                mirror([1, 0]) corner(r = 0.5);
            }
        }

        translate([-1, 1]) {
          difference() {
            square([1, 1], center = false);
            circle(r = 1);
          }
        }
        translate([w, 1]) {
          difference() {
            square([1, 1], center = false);
            translate([1, 0]) {
                circle(r = 1);
            }
          }
        }
    }
}

module jj40_pcb_outline(
    pcb_dim = PCB_DIM,
    corner_r = CORNER_R,
    usb_offset_mid_x = 7.5 + (1.5 * 19.05)
) {
    union() {
        square_with_rounded_corners(dim = pcb_dim, r = corner_r);

        // USB Connector
        translate([usb_offset_mid_x, 0]) {
            pcb_outline_usb_connector();
        }
    }
}

scale([1, -1, 1]) {
    if (include_usb_connector) {
        jj40_pcb_outline();
    } else {
        square_with_rounded_corners(dim = PCB_DIM, r = CORNER_R);
    }
}
