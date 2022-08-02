// Keycap Storage
//
// Box with trays with sections

// Keycap dimensions

keycap_width = 18;
keycap_length = 18;
keycap_height = 15; // SA profile's tallest is under 15mm

num_keycaps_per_row = 12;
num_keycap_rows = 5;

num_trays = 2;

tray_handle_depth = 15;

// Thickness of case material (mm)
thickness = 3;

// Margin in the box around the tray's width.
box_drawer_inner_width_margin = 0.2;

// Margin in the box around the tray's height.
box_drawer_inner_height_margin = 0.2;

// Margin in the tray's section's around a keycap's 'length'.
keycap_length_margin = 0.2;

// Margin in the tray's section's rows.
keycap_row_margin = 2;

num_sections = num_keycap_rows;

tray_section_inner_width = keycap_length + keycap_length_margin;
keycap_length_in_row = keycap_width;
tray_inner_length = keycap_length_in_row * num_keycaps_per_row + keycap_row_margin;

tray_inner_width = (tray_section_inner_width * num_sections) + ((num_sections - 1) * thickness);

tray_inner_height = keycap_height;

tray_height = tray_inner_height + thickness;
tray_width = tray_inner_width + (2 * thickness);
tray_length = tray_inner_length + (2 * thickness);


tray_section_width = function (tray_section_inner_width) tray_section_inner_width + thickness;

tray_handle_slot_width = function (tray_section_inner_width) tray_section_width(tray_section_inner_width) / 2;


module puzzle_piece_edge(
    length,
    thickness,
    segment_count,
    edge_gender = "male",
) {
    for(i = [1 : segment_count]) {
        if (i % 2 == (edge_gender == "male" ? 1 : 0)) {
            let (
                c = i - 1,
                segment_width = length / segment_count
            ) {
                translate([c * segment_width, 0]) {
                    square([segment_width, thickness], center = false);
                }
            }
        }
    }
}

// sides = along the length
module tray_edge_base_sides(
    edge_gender = "male",
    tray_inner_length,
) {
    translate([thickness, 0]) {
        rotate([0, 0, 90]) {
            puzzle_piece_edge(
                length = tray_inner_length,
                thickness = thickness,
                segment_count = 9,
                edge_gender = edge_gender
            );
        }
    }
}

module tray_edge_base_dividers(
    edge_gender = "male",
    tray_inner_length
) {
    tray_edge_base_sides(
        edge_gender = edge_gender,
        tray_inner_length = tray_inner_length
    );
}

module tray_edge_base_front(
    edge_gender = "male",
    tray_inner_width,
) {
    puzzle_piece_edge(
        length = tray_inner_width,
        thickness = thickness,
        segment_count = 5,
        edge_gender = edge_gender
    );
}

module tray_edge_front_sides(
    edge_gender = "male",
    tray_inner_height,
) {
    puzzle_piece_edge(
        length = tray_inner_height,
        thickness = thickness,
        segment_count = 3,
        edge_gender = edge_gender
    );
}

module tray_edge_front_handle(
    num_sections,
    tray_section_inner_width,
) {
    // want to be *between* the
    // slots for the section separators
    // on the front.
    if (num_sections % 2 == 0) {
        translate([-(tray_section_width(tray_section_inner_width) * (3 / 2)), 0]) {
            for (i = [1 : 4]) {
                translate([(i - 1) * tray_section_width(tray_section_inner_width), 0]) {
                    square([tray_handle_slot_width(tray_section_inner_width), thickness], center = true);
                }
            }
        }
    } else {
        translate([-(tray_section_width(tray_section_inner_width) * (2 / 2)), 0]) {
            for (i = [1 : 3]) {
                translate([(i - 1) * tray_section_width(tray_section_inner_width), 0]) {
                    square([tray_handle_slot_width(tray_section_inner_width), thickness], center = true);
                }
            }
        }
    }
}

module tray_base(
    num_sections,
    tray_inner_width,
    tray_inner_length,
    tray_section_inner_width,
) {
    difference() {
        union() {
            // Base
            translate([thickness, thickness]) {
                square([tray_inner_width, tray_inner_length], center = false);
            }

            // Front edge
            translate([thickness, 0]) {
                tray_edge_base_front(
                    edge_gender = "female",
                    tray_inner_width = tray_inner_width
                );
            }

            // Back edge
            translate([thickness, tray_inner_length + thickness]) {
                tray_edge_base_front(
                    edge_gender = "female",
                    tray_inner_width = tray_inner_width
                );
            }

            // Left edge
            translate([0, thickness]) {
                tray_edge_base_sides(
                    tray_inner_length = tray_inner_length
                );
            }

            // Right edge
            translate([thickness + tray_inner_width, thickness]) {
                tray_edge_base_sides(
                    tray_inner_length = tray_inner_length
                );
            }
        }

        // Dividers
        translate([thickness, thickness]) {
            for(i = [1 : (num_sections - 1)]) {
                translate([
                    (i * tray_section_width(tray_section_inner_width)) - thickness,
                    0
                ]) {
                    tray_edge_base_dividers(
                        edge_gender = "female",
                        tray_inner_length = tray_inner_length
                    );
                }
            }
        }
    }
}

module tray_side(
    tray_inner_length,
    tray_inner_height,
) {
    // x axis => z axis in assembled box

    tray_edge_front_sides(
        edge_gender = "female",
        tray_inner_height = tray_inner_height
    );
    translate([0, thickness]) {
        square([tray_inner_height, tray_inner_length], center = false);
    }
    translate([tray_inner_height, thickness]) {
        tray_edge_base_sides(
            edge_gender = "female",
            tray_inner_length = tray_inner_length
        );
    }
    translate([0, thickness + tray_inner_length]) {
        tray_edge_front_sides(
            edge_gender = "female",
            tray_inner_height = tray_inner_height
        );
    }
}

module tray_back(
    num_sections,
    tray_inner_width,
    tray_inner_height,
    tray_section_inner_width,
) {
    difference() {
        union() {
            translate([thickness, thickness]) {
                rotate([0, 0, 90]) {
                    tray_edge_front_sides(
                        edge_gender = "male",
                        tray_inner_height = tray_inner_height
                    );
                }
            }
            translate([thickness, thickness]) {
                square([tray_inner_width, tray_inner_height], center = false);
            }
            translate([thickness, 0]) {
                tray_edge_base_front(
                    edge_gender = "male",
                    tray_inner_width = tray_inner_width
                );
            }
            translate([thickness + tray_inner_width + thickness, thickness]) {
                rotate([0, 0, 90]) {
                    tray_edge_front_sides(
                        edge_gender = "male",
                        tray_inner_height = tray_inner_height
                    );
                }
            }

            translate([0, 0]) {
                square([thickness, thickness], center = false);
            }
            translate([thickness + tray_inner_width, 0]) {
                square([thickness, thickness], center = false);
            }
        }

        translate([thickness, thickness]) {
            for (i = [1 : (num_sections - 1)]) {
                translate([
                    (i * tray_section_width(tray_section_inner_width)),
                    0
                ]) {
                    rotate([0, 0, 90]) {
                        tray_edge_front_sides(
                            edge_gender = "female",
                            tray_inner_height = tray_inner_height
                        );
                    }
                }
            }
        }
    }
}

module tray_front(
    num_sections,
    tray_inner_width,
    tray_inner_height,
    tray_section_inner_width,
) {
    tray_height = tray_inner_height + thickness;

    difference() {
        translate([0, tray_height]) {
            scale([1, -1]) {
                tray_back(
                    num_sections = num_sections,
                    tray_inner_width = tray_inner_width,
                    tray_inner_height = tray_inner_height,
                    tray_section_inner_width = tray_section_inner_width
                );
            }
        }

        translate([thickness + (tray_inner_width / 2), tray_inner_height / 2]) {
            tray_edge_front_handle(
                num_sections = num_sections,
                tray_section_inner_width = tray_section_inner_width
            );
        }
    }
}

tray_handle_width = function (num_sections, tray_section_inner_width)
    num_sections % 2 == 0 ?
        (tray_section_width(tray_section_inner_width) * 3) + tray_handle_slot_width(tray_section_inner_width) :
        (tray_section_width(tray_section_inner_width) * 2) + tray_handle_slot_width(tray_section_inner_width);

module tray_handle(
    corner_radius = 10,
    num_sections,
    tray_inner_width,
    tray_section_inner_width,
) {
    translate([thickness + (tray_inner_width / 2), 0]) {
        translate([0, thickness / 2]) {
            tray_edge_front_handle(
                num_sections = num_sections,
                tray_section_inner_width = tray_section_inner_width
            );
        }

        difference() {
            offset(r = corner_radius) {
                handle_width = tray_handle_width(num_sections, tray_section_inner_width);
                square([handle_width - (2 * corner_radius), (2 * (tray_handle_depth - corner_radius))], center = true);
            }

            translate([0, 50]) {
                handle_width = tray_handle_width(num_sections, tray_section_inner_width);
                square([handle_width, 100], center = true);
            }
        }
    }
}

// for checking alignment of the parts
module tray_aligned(
    num_sections,
    tray_inner_width,
    tray_inner_length,
    tray_inner_height,
    tray_section_inner_width,
) {
    tray_height = tray_inner_height + thickness;
    tray_width = tray_inner_width + (2 * thickness);
    tray_length = tray_inner_length + (2 * thickness);

    // Base
    translate([tray_height + 1, tray_height + 1]) {
        tray_base(
            num_sections = num_sections,
            tray_inner_width = tray_inner_width,
            tray_inner_length = tray_inner_length,
            tray_section_inner_width = tray_section_inner_width
        );
    }

    // Sides
    translate([0, tray_height]) {
        tray_side(
            tray_inner_length = tray_inner_length,
            tray_inner_height = tray_inner_height
        );
    }

    translate([tray_height + tray_width, tray_height + 1]) {
        translate([tray_height + thickness, 0]) {
            scale([-1, 1]) {
                tray_side(
                    tray_inner_length = tray_inner_length,
                    tray_inner_height = tray_inner_height
                );
            }
        }
    }

    // Dividers
    translate([tray_height + tray_width + tray_height + thickness * 2, tray_height + 1]) {
        for (i = [1 : (num_sections - 1)]) {
            translate([(i - 1) * (tray_height + 3) - 1, 0]) {
                tray_side(
                    tray_inner_length = tray_inner_length,
                    tray_inner_height = tray_inner_height
                );
            }
        }
    }

    // Back
    translate([tray_inner_height + thickness + 1, tray_height + tray_length + 2]) {
        tray_back(
            num_sections = num_sections,
            tray_inner_width = tray_inner_width,
            tray_inner_height = tray_inner_height,
            tray_section_inner_width = tray_section_inner_width
        );
    }

    // Front
    translate([tray_inner_height + thickness + 1, 0]) {
        tray_front(
            num_sections = num_sections,
            tray_inner_width = tray_inner_width,
            tray_inner_height = tray_inner_height,
            tray_section_inner_width = tray_section_inner_width
        );
    }

    // Handle
    translate([tray_inner_height + thickness + 1, -5]) {
        tray_handle(
            num_sections = num_sections,
            tray_inner_width = tray_inner_width,
            tray_section_inner_width = tray_section_inner_width
        );
    }
}

module tray_cut(
    num_sections,
    tray_inner_width,
    tray_inner_length,
    tray_inner_height,
    tray_section_inner_width,
) {
    tray_height = tray_inner_height + thickness;
    tray_width = tray_inner_width + (2 * thickness);
    tray_length = tray_inner_length + (2 * thickness);

    // Base
    translate([0, 0]) {
        tray_base(
            num_sections = num_sections,
            tray_inner_width = tray_inner_width,
            tray_inner_length = tray_inner_length,
            tray_section_inner_width = tray_section_inner_width
        );
    }
    tray_base_right = tray_width + 1;

    // Sides
    translate([tray_base_right, 0]) {
        tray_side(
            tray_inner_length = tray_inner_length,
            tray_inner_height = tray_inner_height
        );
    }
    translate([tray_base_right + tray_height + 1, 0]) {
        tray_side(
            tray_inner_length = tray_inner_length,
            tray_inner_height = tray_inner_height
        );
    }
    tray_sides_right = tray_base_right + (2 * (tray_height + 1));

    // Dividers
    translate([tray_sides_right + 1, 0]) {
        for (i = [1 : (num_sections - 1)]) {
            translate([(i - 1) * (tray_height + 2) - 1, 0]) {
                tray_side(
                    tray_inner_length = tray_inner_length,
                    tray_inner_height = tray_inner_height
                );
            }
        }
    }
    tray_dividers_right = tray_sides_right + ((num_sections - 1) * (tray_height + 1)) + 2;

    // Back
    translate([tray_dividers_right + tray_height + 2, 0]) {
        rotate([0, 0, 90]) {
            tray_back(
                num_sections = num_sections,
                tray_inner_width = tray_inner_width,
                tray_inner_height = tray_inner_height,
                tray_section_inner_width = tray_section_inner_width
            );
        }
    }

    // Front
    translate([tray_dividers_right + tray_height + 2, tray_width + 1]) {
        rotate([0, 0, 90]) {
            tray_front(
                num_sections = num_sections,
                tray_inner_width = tray_inner_width,
                tray_inner_height = tray_inner_height,
                tray_section_inner_width = tray_section_inner_width
            );
        }
    }

    // Handle
    translate([tray_dividers_right + tray_height + thickness + 3, 0]) {
        rotate([0, 0, 90]) {
            tray_handle(
                num_sections = num_sections,
                tray_inner_width = tray_inner_width,
                tray_section_inner_width = tray_section_inner_width
            );
        }
    }
}

module trays_cut(
    num_sections,
    num_trays,
    tray_inner_width,
    tray_inner_length,
    tray_inner_height,
    tray_section_inner_width,
) {
    tray_length = tray_inner_length + (2 * thickness);

    for (i = [1 : num_trays]) {
        translate([0, (i - 1) * -(tray_length + 1)]) {
            tray_cut(
                num_sections = num_sections,
                tray_inner_width = tray_inner_width,
                tray_inner_length = tray_inner_length,
                tray_inner_height = tray_inner_height,
                tray_section_inner_width = tray_section_inner_width
            );
        }
    }
}






module box_edge_base_side(
    edge_gender = "male",
    box_inner_length,
) {
    translate([thickness, 0]) {
        rotate([0, 0, 90]) {
            puzzle_piece_edge(
                length = box_inner_length,
                thickness = thickness,
                segment_count = 7,
                edge_gender = edge_gender
            );
        }
    }
}

module box_edge_base_back(
    edge_gender = "male",
    box_inner_width,
) {
    puzzle_piece_edge(
        length = box_inner_width,
        thickness = thickness,
        segment_count = 5,
        edge_gender = edge_gender
    );
}

module box_edge_side_back(
    edge_gender = "male",
    box_inner_height,
) {
    puzzle_piece_edge(
        length = box_inner_height,
        thickness = thickness,
        segment_count = 3,
        edge_gender = edge_gender
    );
}

module box_base(
    box_inner_width,
    box_inner_length,
) {
    translate([thickness, 0]) {
        square([box_inner_width, box_inner_length], center = false);
    }

    translate([0, 0]) {
        box_edge_base_side(
            edge_gender = "female",
            box_inner_length = box_inner_length
        );
    }

    translate([thickness + box_inner_width, 0]) {
        box_edge_base_side(
            edge_gender = "female",
            box_inner_length = box_inner_length
        );
    }

    translate([thickness, box_inner_length]) {
        box_edge_base_back(
            edge_gender = "female",
            box_inner_width = box_inner_width
        );
    }

    translate([0, box_inner_length]) {
        //square([thickness, thickness], center = false);
    }
    translate([thickness + box_inner_width, box_inner_length]) {
        //square([thickness, thickness], center = false);
    }
}

module box_side(
    num_trays,
    tray_height,
    box_inner_length,
    box_inner_height,
) {
    // x -> z axis
    difference() {
        union() {
            translate([thickness, 0]) {
                square([box_inner_height, box_inner_length], center = false);
            }

            translate([0, 0]) {
                box_edge_base_side(
                    edge_gender = "male",
                    box_inner_length = box_inner_length
                );
            }

            translate([thickness + box_inner_height, 0]) {
                box_edge_base_side(
                    edge_gender = "male",
                    box_inner_length = box_inner_length
                );
            }

            translate([thickness, box_inner_length]) {
                box_edge_side_back(
                    edge_gender = "male",
                    box_inner_height = box_inner_height
                );
            }

            translate([0, box_inner_length]) {
                square([thickness, thickness], center = false);
            }

            translate([thickness + box_inner_height, box_inner_length]) {
                square([thickness, thickness], center = false);
            }
        }

        for (i = [1 : (num_trays - 1)]) {
            translate([i * (thickness + tray_height), 0]) {
                box_edge_base_side(
                    edge_gender = "female",
                    box_inner_length = box_inner_length
                );
            }
        }
    }
}

module box_back(
    num_trays,
    tray_height,
    box_inner_width,
    box_inner_height
) {
    // y -> z axis
    difference() {
        union() {
            translate([thickness, thickness]) {
                square([box_inner_width, box_inner_height], center = false);
            }

            translate([thickness, thickness]) {
                rotate([0, 0, 90]) {
                    box_edge_side_back(
                        edge_gender = "female",
                        box_inner_height = box_inner_height
                    );
                }
            }

            translate([thickness + box_inner_width + thickness, thickness]) {
                rotate([0, 0, 90]) {
                    box_edge_side_back(
                        edge_gender = "female",
                        box_inner_height = box_inner_height
                    );
                }
            }

            translate([thickness, 0]) {
                box_edge_base_back(
                    edge_gender = "male",
                    box_inner_width = box_inner_width
                );
            }
            translate([thickness, thickness + box_inner_height]) {
                box_edge_base_back(
                    edge_gender = "male",
                    box_inner_width = box_inner_width
                );
            }
        }

        for (i = [1 : (num_trays - 1)]) {
            translate([thickness, i * (thickness + tray_height)]) {
                box_edge_base_back(
                    edge_gender = "female",
                    box_inner_width = box_inner_width
                );
            }
        }
    }
}

// for checking alignment of the box pieces
module box_aligned(
    num_trays,
    tray_height,
    box_inner_width,
    box_inner_length,
) {
    box_inner_height = (num_trays * (tray_height + thickness)) - thickness;

    boxHeight = box_inner_height + (2 * thickness);
    boxLength = box_inner_length + thickness;
    boxWidth = box_inner_width + (2 * thickness);

    translate([boxHeight + 1, 0]) {
        box_base(
            box_inner_width = box_inner_width,
            box_inner_length = box_inner_length
        );
    }

    translate([0, 0]) {
        box_side(
            num_trays = num_trays,
            tray_height = tray_height,
            box_inner_length = box_inner_length,
            box_inner_height = box_inner_height
        );
    }

    translate([boxHeight + 1, boxLength + 1]) {
        box_back(
            num_trays = num_trays,
            tray_height = tray_height,
            box_inner_width = box_inner_width,
            box_inner_height = box_inner_height
        );
    }
}

module box_cut(
    num_trays,
    tray_height,
    box_inner_width,
    box_inner_length,
) {
    box_inner_height = (num_trays * (tray_height + thickness)) - thickness;

    boxHeight = box_inner_height + (2 * thickness);
    boxLength = box_inner_length + thickness;
    boxWidth = box_inner_width + (2 * thickness);

    for (i = [0 : num_trays]) {
        translate([i * (boxWidth + 1), 0]) {
            box_base(
                box_inner_width = box_inner_width,
                box_inner_length = box_inner_length
            );
        }
    }

    box_base_right = (num_trays + 1) * (boxWidth + 1);

    translate([box_base_right, 0]) {
        box_side(
            num_trays = num_trays,
            tray_height = tray_height,
            box_inner_length = box_inner_length,
            box_inner_height = box_inner_height
        );
    }
    translate([box_base_right + boxHeight + 1, 0]) {
        box_side(
            num_trays = num_trays,
            tray_height = tray_height,
            box_inner_length = box_inner_length,
            box_inner_height = box_inner_height
        );
    }
    box_side_right = box_base_right + (2 * (boxHeight + 1));

    translate([box_side_right, 0]) {
        box_back(
            num_trays = num_trays,
            tray_height = tray_height,
            box_inner_width = box_inner_width,
            box_inner_height = box_inner_height
        );
    }
}

///
/// Tray:
///

/*
tray_aligned(
    num_sections = num_sections,
    tray_inner_width = tray_inner_width,
    tray_inner_length = tray_inner_length,
    tray_inner_height = tray_inner_height,
    tray_section_inner_width = tray_section_inner_width
);
// */

//*
trays_cut(
    num_sections = num_sections,
    num_trays = num_trays,
    tray_inner_width = tray_inner_width,
    tray_inner_length = tray_inner_length,
    tray_inner_height = tray_inner_height,
    tray_section_inner_width = tray_section_inner_width
);
// */

///
/// Box:
///

/*
box_aligned(
    num_trays = num_trays,
    tray_height = tray_height + box_drawer_inner_height_margin,
    box_inner_width = tray_width + box_drawer_inner_width_margin,
    box_inner_length = tray_length
);
// */

//*
translate([0, tray_length + thickness + 1]) {
    box_cut(
        num_trays = num_trays,
        tray_height = tray_height + box_drawer_inner_height_margin,
        box_inner_width = tray_width + box_drawer_inner_width_margin,
        box_inner_length = tray_length
    );
}
// */
