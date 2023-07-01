// Design for laser cutting a keyboard tenting stand.
//
// With use_puzzle_edge = true, the resulting pieces
// can be connected together to assemble the keyboard stand.
// With use_puzzle_edge = false, the sides and plate lip
// should be folded precisely.

$fn = 50;

// Thickness of the material.
// e.g. thickness = 4 is for 4mm thick acrylic.
//
// Affects the depth of the "puzzle piece" edge
// so that it slots nicely.
thickness = 4;

// Width of the plate.
base_width = 130;

// Height of the plate.
base_height = 120;

// Diameter of the screw holes in the side plate(s).
screw_hole_diameter = 3.2;

// Radius of the corners, affecting:
// - the main plate
// - the lip edge
rounded_corner_radius = 3;

// The number of segments the 'puzzle piece edge'
// is split into.
puzzle_piece_segment_count = 9;

// Angle increment between the screw holes on the
// side of the tenting stand.
//
// Take care that this is large enough to allow enough
// space between the screw holes.
tenting_angle_increment = 5;

// Angle of the side of the tenting stand.
//
// Larger angle allows for a wider variety of tenting angles,
// but also means a larger minimum tenting angle.
tenting_side_angle = 25;

// Extra pieces which can attach to the side (using screws + nuts)
// to vary the stand's tenting angle.
tenting_extra_pieces_angles = [25];

// Height of the stand's "lip".
//
// Take care that this is smaller than the position of
// the USB connector, if the USB-connector
// is towards the outside.
lip_height = 8;

// When true: use "puzzle piece edge" as a method of
// connecting the main plate to the side plates, lip.
//
// Otherwise: connect using a surface. The 'sides' can then
// be folded down, 'lip' be folded up.
use_puzzle_edge = true;

// When use_puzzle_edge is false,
// this affects the distance for folding between the main part,
// and the sides / plate lip.
fold_allowance = 10;

module puzzle_piece_edge(
    length,
    thickness,
    segment_count,
    edge_gender
) {
    for(i = [1 : puzzle_piece_segment_count]) {
        if (i % 2 == (edge_gender == "male" ? 1 : 0)) {
            let (
                c = i - (segment_count / 2) - 0.5,
                segment_width = length / segment_count
            ) {
                translate([c * segment_width, thickness / 2]) {
                    square([segment_width, thickness], center = true);
                }
            }
        }
    }
}

module main_plate(
    width,
    height,
    screw_hole_diameter,
    rounded_corner_radius,
    edge_type
) {
    let (
        side_corner_radius = 1.5 * screw_hole_diameter,
        edge_height = height,
        edge_width = width - (2 * side_corner_radius)
    ) {
        // Extend base beyond 'puzzle piece edge', round its corners
        translate([-(edge_width / 2), 0]) {
            let (
                r = rounded_corner_radius
            ) {
                minkowski() {
                    square([(2 * side_corner_radius) - (2 * r), height - (2 * r)], center = true);
                    circle(r);
                }
            }
        }

        // Fill in the with square the size of edge width/length
        square([edge_width, height], center = true);

        // Extend edge opposite the lip, round its corners
        translate([edge_width / 2, 0]) {
            square([2 * side_corner_radius, height], center = true);
        }

        if (edge_type == "puzzle_piece") {
            // "puzzle piece"-like edge along the lower edge
            translate([width / 2, 0]) {
                rotate(270) {
                    puzzle_piece_edge(
                        length = edge_height,
                        thickness = thickness,
                        segment_count = puzzle_piece_segment_count,
                        edge_gender = "female"
                    );
                }
            }

            translate([0, (edge_height / 2)]) {
                rotate(0) {
                    puzzle_piece_edge(
                        length = edge_width,
                        thickness = thickness,
                        segment_count = puzzle_piece_segment_count,
                        edge_gender = "female"
                    );
                }
            }

            translate([0, -(edge_height / 2)]) {
                rotate(180) {
                    puzzle_piece_edge(
                        length = edge_width,
                        thickness = thickness,
                        segment_count = puzzle_piece_segment_count,
                        edge_gender = "female"
                    );
                }
            }
        }
    }
}

module plate_lip(
    length,
    height = 8,
    rounded_corner_radius,
    edge_type
) {
    difference() {
        let(
          r = rounded_corner_radius
        ) {
            minkowski() {
                square([(2 * height) - (2 * r), length - (2 * r)], center = true);
                circle(r);
            }
        }

        // avoid fighting at the edge by making the shape
        // by adding a bit extra so that it's
        // wider than what it's subtracted from.
        extra = 1;
        translate([-((height / 2) + extra), 0]) {
            square([height + (2 * extra), length], center = true);
        }
    }

    if (edge_type == "puzzle_piece") {
        translate([-height / 2, 0]) {
            rotate(270) {
                puzzle_piece_edge(
                    length = length,
                    thickness = thickness,
                    segment_count = puzzle_piece_segment_count,
                    edge_gender = "male"
                );
            }
        }
    }
}

module arc_hull_with_screw_holes(
    length,
    screw_hole_diameter,
    max_angle,
    edge_type,
    drill_hole_count,
    angle_increment = 8
) {
    let (
        corner_radius = 1.5 * screw_hole_diameter,
        edge_length = length - (2 * corner_radius)
    ) {
        translate([0, corner_radius, 0]){
            difference() {
                // Hull of an arc with angle `max_angle`, radius length `height`.
                hull() {
                    translate([edge_length / 2, 0]) {
                        circle(r = corner_radius);

                        for(angle = [0 : 5 : max_angle]) {
                            rotate(-angle) {
                                translate([-(edge_length), 0]) {
                                    circle(r = corner_radius);
                                }
                            }
                        }
                    }
                }

                translate([edge_length / 2, 0]) {
                    circle(d = screw_hole_diameter);
                    num_holes = is_undef(drill_hole_count) ? floor(max_angle / angle_increment) : drill_hole_count;
                    for(i = [0 : num_holes - 1]) {
                        rotate(-(max_angle - (i * angle_increment))) {
                                translate([-edge_length, 0]) {
                                    circle(d = screw_hole_diameter);
                                }
                        }
                    }
                }
            }

            // "puzzle piece"-like edge
            if (edge_type == "puzzle_piece") {
                translate([0, -corner_radius]) {
                    rotate(180) {
                        puzzle_piece_edge(
                            length = edge_length,
                            thickness = thickness,
                            segment_count = puzzle_piece_segment_count,
                            edge_gender = "male"
                        );
                    }
                }
            }
        }
    }
}

// TODO this should be a module, so can use <>;

module keyboard_tenting_stand() {
    let(
        clearance = (use_puzzle_edge ? thickness * 3 : fold_allowance),
        translate_lip_x = (base_width / 2) + clearance,
        translate_side_y = (base_height / 2) + clearance,
        edge_type = use_puzzle_edge ? "puzzle_piece" : "folded"
    ) {
        main_plate(
            width = base_width,
            height = base_height,
            screw_hole_diameter = screw_hole_diameter,
            rounded_corner_radius = rounded_corner_radius,
            edge_type = edge_type
        );

        translate([translate_lip_x, 0]) {
            plate_lip(
                length = base_height,
                rounded_corner_radius = rounded_corner_radius,
                edge_type = edge_type,
                height = lip_height
            );
        }

        translate([0, translate_side_y]) {
            arc_hull_with_screw_holes(
                length = base_width,
                screw_hole_diameter = screw_hole_diameter,
                max_angle = tenting_side_angle,
                edge_type = edge_type,
                angle_increment = tenting_angle_increment
            );
        }

        if (len(tenting_extra_pieces_angles) > 0) {
            for (i = [1 : len(tenting_extra_pieces_angles)]) {
                angle = tenting_extra_pieces_angles[i - 1];
                translate([0, 150 * i]) {
                    arc_hull_with_screw_holes(
                        length = base_width,
                        screw_hole_diameter = screw_hole_diameter,
                        max_angle = angle,
                        drill_hole_count = 1
                    );
                }
            }
        }

        mirror([0, 1, 0]) {
            translate([0, translate_side_y]) {
                arc_hull_with_screw_holes(
                    length = base_width,
                    screw_hole_diameter = screw_hole_diameter,
                    max_angle = tenting_side_angle,
                    edge_type = edge_type,
                    angle_increment = tenting_angle_increment
                );
            }

            if (len(tenting_extra_pieces_angles) > 0) {
                for (i = [1 : len(tenting_extra_pieces_angles)]) {
                    angle = tenting_extra_pieces_angles[i - 1];
                    translate([0, 150 * i]) {
                        arc_hull_with_screw_holes(
                            length = base_width,
                            screw_hole_diameter = screw_hole_diameter,
                            max_angle = angle,
                            drill_hole_count = 1
                        );
                    }
                }
            }
        }

        if (!use_puzzle_edge) {
            // between main piece and the lip edge
            translate([translate_lip_x - (fold_allowance / 2), 0]) {
                square([fold_allowance, base_height - 1], center = true);
            }

            translate([0, translate_side_y - (fold_allowance / 2)]) {
                square([base_height - 8, fold_allowance * 1.2], center = true);
            }
            mirror([0, 1, 0]) {
                translate([0, translate_side_y - (fold_allowance / 2)]) {
                    square([base_height - 8, fold_allowance * 1.2], center = true);
                }
            }
        }
    }
}

keyboard_tenting_stand();
