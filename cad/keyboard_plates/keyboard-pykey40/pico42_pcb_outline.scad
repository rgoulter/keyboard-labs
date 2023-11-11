// definition for the PCB outline for ortho 4x12 keyboard,
// without extra margin for HotSwap sockets.

include <jj40_constants.scad>
use <pcb_outline.scad>

$fn = 60;

include_usb_connector = false;

pcb_switch_margin = 0.5;
pico42_dim = [
  2*SW_CUTOUT_HALFWIDTH + 2 * pcb_switch_margin + (12 - 1) * SWITCH_GRID_UNIT,
  2*SW_CUTOUT_HALFWIDTH + 2 * pcb_switch_margin + (4 - 1) * SWITCH_GRID_UNIT
];

module pico42_pcb_outline(
    include_usb_connector = include_usb_connector
) {
    pcb_outline(
        pcb_dim = pico42_dim,
        corner_r = 1,
        usb_offset_mid_x = 7.5 + (1.5 * 19.05) - 0.5,
        include_usb_connector = include_usb_connector
    );
}

scale([1, -1, 1]) {
    echo(pcb_dim = pico42_dim);
    pico42_pcb_outline(include_usb_connector = include_usb_connector);
}
