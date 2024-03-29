__layer_colors = ["Khaki", "Gold"];

module __layered_case_border(
    margin = 2,
    case_border_thickness = 10,
    layer_thickness = 3,
) {
    linear_extrude(layer_thickness) {
        difference() {
            offset(r = margin + case_border_thickness) {
                children(0);
            };
            offset(r = margin) {
                children(0);
            };
        }
    }
}

module __layered_case_bottom_plate(
    margin = 2,
    case_border_thickness = 10,
    layer_thickness = 3,
) {
    linear_extrude(layer_thickness) {
        offset(r = margin + case_border_thickness) {
            children(0);
        };
    }
}

// Layers of the case, without subtraction
module __layered_case_tray_mount_box(
    margin = 2,
    case_border_thickness = 10,
    layer_thickness = 3,
    layers_above_origin = 4,
    layers_below_origin = 4,
) {
    if (layers_above_origin > 0) {
        for (top_layer_idx = [1 : layers_above_origin]) {
            translate([0, 0, (top_layer_idx - 1) * layer_thickness]) {
                color(__layer_colors[top_layer_idx % 2]) {
                    __layered_case_border(
                        margin = margin,
                        case_border_thickness = case_border_thickness,
                        layer_thickness = layer_thickness
                    ) {
                        children(0);
                    }
                }
            }
        }
    }

    if (layers_below_origin > 1) {
        for (bottom_layer_idx = [1 : (layers_below_origin - 1)]) {
            translate([0, 0, -(bottom_layer_idx * layer_thickness)]) {
                color(__layer_colors[(bottom_layer_idx - 1) % 2]) {
                    __layered_case_border(
                        margin = margin,
                        case_border_thickness = case_border_thickness,
                        layer_thickness = layer_thickness
                    ) {
                        children(0);
                    }
                }
            }
        }
    }

    if (layers_below_origin > 0) {
        translate([0, 0, -(layers_below_origin * layer_thickness)]) {
            color(__layer_colors[(layers_below_origin - 1) % 2]) {
                __layered_case_bottom_plate(
                    margin = margin,
                    case_border_thickness = case_border_thickness,
                    layer_thickness = layer_thickness
                ) {
                    children(0);
                }
            }
        }
    }
}

module layered_pseudo_tray_mount_case(
    margin = 2,
    case_border_thickness = 10,
    layer_thickness = 3,
    layers_above_origin = 4,
    layers_below_origin = 4,
) {
    difference() {
        __layered_case_tray_mount_box(
            margin = margin,
            case_border_thickness = case_border_thickness,
            layer_thickness = layer_thickness,
            layers_above_origin = layers_above_origin,
            layers_below_origin = layers_below_origin
        ) {
            children(0);
        }

        if ($children > 1) {
            for (i = [2:$children]) {
                children(i - 1);
            }
        }
    }
}

module __slice_of(
    offsetZ,
    layer_thickness = 3,
) {
    intersection() {
        translate([-500, -500]) {
            cube([1000, 1000, layer_thickness]);
        }

        translate([0, 0, offsetZ]) {
            children(0);
        }
    }
}

module layered_projections(
    projection_dy = 150,
    layer_thickness = 3,
    layers_above_origin = 4,
    layers_below_origin = 4,
    debug_offset_x = 350,
    debug_delta_z = 30,
    show_3D = true,
) {
    total_layer_count = layers_above_origin + layers_below_origin;

    if ($preview && show_3D) {
        translate([0, -projection_dy, 0]) {
            children(0);
        }
    }

    for (i = [1 : total_layer_count]) {
        deltaZ = (layers_above_origin * -layer_thickness) + ((i) * layer_thickness) - 0.01;

        translate([debug_offset_x, -projection_dy, ((total_layer_count - i) * debug_delta_z)]) {
            if ($preview && show_3D) {
                color(__layer_colors[i % 2]) {
                    __slice_of(
                        layer_thickness = layer_thickness,
                        offsetZ = deltaZ
                    ) {
                        children(0);
                    }
                }
            }
        }

        translate([0, (i - 1) * projection_dy, 0]) {
            if ($preview && show_3D) {
                color(__layer_colors[i % 2]) {
                    translate([debug_offset_x, 0, 0]) {
                        __slice_of(
                            layer_thickness = layer_thickness,
                            offsetZ = deltaZ
                        ) {
                            children(0);
                        }
                    }
                }
            }

            projection(cut = true) {
                translate([0, 0, deltaZ]) {
                    children(0);
                }
            }
        }
    }
}

module screw_hole(
  screw_diameter = 2,
  screw_hole_extra_diameter = 0.2,
  screw_hole_top_z = 100,
  screw_hole_bottom_z = -100,
  use_3D = true,
) {
    if (use_3D) {
        translate([0, 0, screw_hole_bottom_z]) {
            cylinder(
                h = screw_hole_top_z - screw_hole_bottom_z,
                d = screw_diameter + screw_hole_extra_diameter
            );
        }
    }

    circle(
        d = screw_diameter + screw_hole_extra_diameter
    );
}

module screws_at(
    points = [],
    screw_diameter = 2,
    screw_hole_extra_diameter = 0.2,
    screw_hole_top_z = 100,
    screw_hole_bottom_z = -100,
) {
    for (point = points) {
        translate(point) {
            screw_hole(
                screw_diameter = screw_diameter,
                screw_hole_extra_diameter = screw_hole_extra_diameter,
                screw_hole_top_z = screw_hole_top_z,
                screw_hole_bottom_z = screw_hole_bottom_z
            );
        }
    }
}

module screw_holes_along_segment(
    start_point,
    end_point,
    num_screws_between,
    inclusive_begin = true,
    inclusive_end = false,
    screw_diameter = 2,
    screw_hole_extra_diameter = 0.2,
    screw_hole_top_z = 100,
    screw_hole_bottom_z = -100,
    use_3D = true,
) {
    delta = (end_point - start_point) / (num_screws_between + 1);

    if (inclusive_begin) {
        translate(start_point) {
            screw_hole(
                screw_diameter = screw_diameter,
                screw_hole_extra_diameter = screw_hole_extra_diameter,
                screw_hole_top_z = screw_hole_top_z,
                screw_hole_bottom_z = screw_hole_bottom_z,
                use_3D = use_3D
            );
        }
    }

    for (i = [1 : num_screws_between]) {
        translate(start_point + (delta * i)) {
            screw_hole(
                screw_diameter = screw_diameter,
                screw_hole_extra_diameter = screw_hole_extra_diameter,
                screw_hole_top_z = screw_hole_top_z,
                screw_hole_bottom_z = screw_hole_bottom_z,
                use_3D = use_3D
            );
        }
    }

    if (inclusive_end) {
        translate(end_point) {
            screw_hole(
                screw_diameter = screw_diameter,
                screw_hole_extra_diameter = screw_hole_extra_diameter,
                screw_hole_top_z = screw_hole_top_z,
                screw_hole_bottom_z = screw_hole_bottom_z,
                use_3D = use_3D
            );
        }
    }
}

module case_screw_holes(
    case_border_thickness_mm,
    pcb_dimensions,
    screw_diameter_mm = 2,
    num_screws_along_long_edge = 3,
    num_screws_along_short_edge = 1,
    screw_hole_top_z = 100,
    screw_hole_bottom_z = -100,
    screw_hole_extra_diameter = 0.2,
    use_3D = true,
) {
    // WIP: surely needs margin here??
    screwsLeft = -1 - (case_border_thickness_mm / 2);
    screwsTop = -1 - (case_border_thickness_mm / 2);
    screwsRight = pcb_dimensions[0] + 1 + (case_border_thickness_mm / 2);
    screwsBottom = pcb_dimensions[1] + 1 + (case_border_thickness_mm / 2);

    // Corner screws
    r = 1 + case_border_thickness_mm / 2;
    translate([r * cos(3 * 360 / 8), r * -sin(3 * 360 / 8)]) {
        screw_hole(
            screw_diameter = screw_diameter_mm,
            screw_hole_extra_diameter = screw_hole_extra_diameter,
            screw_hole_top_z = screw_hole_top_z,
            screw_hole_bottom_z = screw_hole_bottom_z,
            use_3D = use_3D
        );
    }
    translate([pcb_dimensions[0], 0] + [r * cos(1 * 360 / 8), r * -sin(1 * 360 / 8)]) {
        screw_hole(
            screw_diameter = screw_diameter_mm,
            screw_hole_extra_diameter = screw_hole_extra_diameter,
            screw_hole_top_z = screw_hole_top_z,
            screw_hole_bottom_z = screw_hole_bottom_z,
            use_3D = use_3D
        );
    }
    translate([0, pcb_dimensions[1]] + [r * cos(5 * 360 / 8), r * -sin(5 * 360 / 8)]) {
        screw_hole(
            screw_diameter = screw_diameter_mm,
            screw_hole_extra_diameter = screw_hole_extra_diameter,
            screw_hole_top_z = screw_hole_top_z,
            screw_hole_bottom_z = screw_hole_bottom_z,
            use_3D = use_3D
        );
    }
    translate([pcb_dimensions[0], pcb_dimensions[1]] + [r * cos(7 * 360 / 8), r * -sin(7 * 360 / 8)]) {
        screw_hole(
            screw_diameter = screw_diameter_mm,
            screw_hole_extra_diameter = screw_hole_extra_diameter,
            screw_hole_top_z = screw_hole_top_z,
            screw_hole_bottom_z = screw_hole_bottom_z,
            use_3D = use_3D
        );
    }

    screw_holes_along_segment(
        start_point = [screwsLeft,  screwsTop],
        end_point   = [screwsRight, screwsTop],
        inclusive_begin = false,
        num_screws_between = num_screws_along_long_edge,
        screw_diameter = screw_diameter_mm,
        use_3D = use_3D
    );
    screw_holes_along_segment(
        start_point = [screwsRight,  screwsBottom],
        end_point   = [screwsLeft, screwsBottom],
        inclusive_begin = false,
        num_screws_between = num_screws_along_long_edge,
        screw_diameter = screw_diameter_mm,
        use_3D = use_3D
    );
    screw_holes_along_segment(
        start_point = [screwsRight, screwsTop],
        end_point   = [screwsRight, screwsBottom],
        inclusive_begin = false,
        num_screws_between = num_screws_along_short_edge,
        screw_diameter = screw_diameter_mm,
        use_3D = use_3D
    );
    screw_holes_along_segment(
        start_point = [screwsLeft, screwsBottom],
        end_point   = [screwsLeft, screwsTop],
        inclusive_begin = false,
        num_screws_between = num_screws_along_short_edge,
        screw_diameter = screw_diameter_mm,
        use_3D = use_3D
    );
}
