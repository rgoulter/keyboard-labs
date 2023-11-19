// Plate cover for the X-2, covering the middle MCU area.

use <plate-devboard_cover.scad>;

$fn = 64;

pcb_left   = 50;
pcb_top    = 50;
pcb_bottom = 144.2;

h1_x = 168.68748;
h1_y =  54.23755;
h4_x = 216.31252;
h4_y = 139.367309;

holes_distance_width  = h4_x - h1_x;
holes_distance_height = h4_y - h1_y;
margin = 4;

screw_hole_dia = 2.2;

// relative to h1
u1_pad1_position = [184.88, 55.18365] - [h1_x, h1_y];

// relative to h1
minif4_reset_buttons_offset = u1_pad1_position + [7.5, 14.4];

cutout_button_hole = false;

module x2_devboard_cover_plate_for_minif4() {
    devboard_cover_plate(
        outer_margin = margin,
        holes_distance_width = holes_distance_width,
        holes_distance_height = holes_distance_height,
        cutout_button_hole = true,
        buttons_offset = minif4_reset_buttons_offset
    );
}

// With cutout for accessing button of MiniF4
x2_devboard_cover_plate_for_minif4();
