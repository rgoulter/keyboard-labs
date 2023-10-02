// definition for the PCB outline for the edge cuts layer for the PCB.

include <jj40_constants.scad>
use <common.scad>

$fn = 60;

include_usb_connector = true;

module jj40_pcb_outline() {
    union() {
        square_with_rounded_corners(dim = [pcb_width, pcb_height], r = corner_r);

        // USB Connector
        extraW = 2;
        translate([31.5 - (extraW / 2), -2]) {
            w = 9 + extraW;
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
}

scale([1, -1, 1]) {
    if (include_usb_connector) {
        jj40_pcb_outline();
    } else {
        square_with_rounded_corners(dim = [pcb_width, pcb_height], r = corner_r);
    }
}
