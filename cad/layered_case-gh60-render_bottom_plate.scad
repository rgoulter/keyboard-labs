// Layered Acrylic Case for GH60-compatible PCB.
//
// The OpenSCAD Preview additionally shows the assembled case,
//  as well as slices of the case to assist in debugging.

// BUG: 2021-12-20: The HOLES A, F don't align with the X-2 PCB(!!),
//                   which uses the same position as GH-60.
//                  - (And other notes as listed in plate-x2_rev2021.1.scad apply here)

include <layered_case-gh60.scad>;

$fn = 60;

gh60_layered_case(
    show_3D = false,
    number_of_layers_above_pcb = 0,
    number_of_layers_below_pcb = 1,
    hole_for_usb_connector = false
);
