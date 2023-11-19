// Plate cover for the X-2, covering the middle MCU area.

use <plate-devboard_cover.scad>;

$fn = 64;

pcb_left   = 50;
pcb_top    = 50;

// H7
h1_x = 146.225;
h1_y =  53.5;
// H9
h4_x = 178.325;
h4_y =  83.075;

holes_distance_width  = h4_x - h1_x;
holes_distance_height = h4_y - h1_y;
margin = 2;

screw_hole_dia = 2.2;

// relative to h1
u1_pad1_position = [154.655, 51.524] - [h1_x, h1_y];

// distance between pad 32 and 3V3
devboard_headers_width = 15.24;

buttons_offset = u1_pad1_position + [devboard_headers_width / 2, (8) * 2.54];

module ch552_44_devboard_cover_plate() {
    devboard_cover_plate(
        outer_margin = margin,
        holes_distance_width = holes_distance_width,
        holes_distance_height = holes_distance_height,
        cutout_button_hole = true,
        // relative to "H1" (H7)
        buttons_offset = buttons_offset
    );
}

ch552_44_devboard_cover_plate();
