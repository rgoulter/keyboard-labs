// Illustrative demonstration of what the
// keyboard tenting stand should look like if
// the puzzle-pieces are joined together.

$fn = 50;

use <keyboard_tenting_stand.scad>;

// Thickness of the material.
// Affects the depth of the "puzzle piece" edge
// so that it slots nicely.
thickness = 4;

// Width of the plate.
base_width = 100;

// Height of the plate.
base_height = 100;

// Diameter of the screw holes in the side plate(s).
screw_hole_diameter = 3.2;

// Radius of the corners, affecting:
// - the main plate
// - the lip edge
rounded_corner_radius = 3;

// The number of segments the 'puzzle piece edge'
// is split into.
puzzle_piece_segment_count = 9;

// When true: use "puzzle piece edge" as a method of
// connecting the main plate to the side plates, lip.
//
// Otherwise: connect using a surface. The 'sides' can then
// be folded down, 'lip' be folded up.
use_puzzle_edge = true;



let(
    fold_allowance = 2 * 5,
    clearance = (use_puzzle_edge ? 0 : 2 * 5),
    translate_lip_x = (base_width / 2) + clearance + (thickness / 2),
    translate_side_y = (base_height / 2) + clearance,
    edge_type = use_puzzle_edge ? "puzzle_piece" : "folded"
) {
    translate([base_width / 2, 0, 3 * screw_hole_diameter - 1]) {
        rotate(25, [0, 1, 0]) {
            translate([-(base_width / 2), 0, 0]) {
                translate([0, 0, -(thickness / 2)]) {
                    color("SkyBlue", alpha = 0.7) {
                        linear_extrude(thickness) {
                            main_plate(
                                width = base_width,
                                height = base_height,
                                screw_hole_diameter = screw_hole_diameter,
                                rounded_corner_radius = rounded_corner_radius,
                                edge_type = edge_type
                            );
                        }
                    }
                }

                translate([translate_lip_x, 0, thickness / 2]) {
                    rotate(270, [0, 1, 0]) {
                        translate([0, 0, -(thickness / 2)]) {
                            color("MediumTurquoise", alpha = 0.7) {
                                linear_extrude(thickness) {
                                    plate_lip(
                                        length = base_height,
                                        rounded_corner_radius = rounded_corner_radius,
                                        edge_type = edge_type
                                    );
                                }
                            }
                        }
                    }
                }

                translate([0, translate_side_y + (thickness / 2), -(thickness / 2)]) {        
                    rotate(270, [1, 0, 0]) {
                        translate([0, 0, -(thickness / 2)]) {
                            color("Aquamarine", alpha = 0.7) {
                                linear_extrude(thickness) {
                                    arc_hull_with_screw_holes(
                                        length = base_width,
                                        screw_hole_diameter = screw_hole_diameter,
                                        max_angle = 25,
                                        edge_type = edge_type
                                    );
                                }
                            }
                        }
                    }
                }

                // Without the 0.01,
                // openscad doesn't render this.
                // This file is meant for illustrative purposes.
                translate([0, -(translate_side_y + (thickness / 2) + 0.01), -(thickness / 2)]) {        
                    rotate(270, [1, 0, 0]) {
                        translate([0, 0, -(thickness / 2)]) {
                            color("Aquamarine", alpha = 0.7) {
                                linear_extrude(thickness) {
                                    arc_hull_with_screw_holes(
                                        length = base_width,
                                        screw_hole_diameter = screw_hole_diameter,
                                        max_angle = 25,
                                        edge_type = edge_type
                                    );
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}