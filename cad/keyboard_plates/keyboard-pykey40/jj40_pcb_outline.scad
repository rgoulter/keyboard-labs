// definition for the PCB outline for the edge cuts layer for the PCB.

include <jj40_constants.scad>
use <pcb_outline.scad>

$fn = 60;

include_usb_connector = true;

module jj40_pcb_outline(
    include_usb_connector = include_usb_connector
) {
    pcb_outline(
        pcb_dim = PCB_DIM,
        corner_r = CORNER_R,
        usb_offset_mid_x = 7.5 + (1.5 * 19.05),
        include_usb_connector = include_usb_connector
    );
}

scale([1, -1, 1]) {
    jj40_pcb_outline(include_usb_connector = include_usb_connector);
}
