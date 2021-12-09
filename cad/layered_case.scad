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
    layer_colors = ["Khaki", "Gold"];

    if (layers_above_origin > 0) {
        for (top_layer_idx = [1 : layers_above_origin]) {
            translate([0, 0, (top_layer_idx - 1) * layer_thickness]) {
                color(layer_colors[top_layer_idx % 2]) {
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
                color(layer_colors[(bottom_layer_idx - 1) % 2]) {
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
            color(layer_colors[(layers_below_origin - 1) % 2]) {
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

module layered_projections(
    projection_dy = 150,
    layer_thickness = 3,
    layers_above_origin = 4,
    layers_below_origin = 4,
    debug_offset_x = 350,
) {
    total_layer_count = layers_above_origin + layers_below_origin;

    if ($preview) {        
        translate([debug_offset_x, -projection_dy, 0]) {
            children(0);
        }
    }

    for (i = [1 : total_layer_count]) {
        // XXX how to handle?
        deltaZ = (layers_above_origin * -layer_thickness) + ((i) * layer_thickness) - 0.01;

        translate([0, (i - 1) * projection_dy, 0]) {
            if ($preview) {
                translate([debug_offset_x, 0, 0]) {
                    intersection() {
                        translate([-500, -500]) {
                            cube([1000, 1000, 3]);
                        }

                        translate([0, 0, deltaZ]) {
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
) {
    translate([0, 0, screw_hole_bottom_z]) {
        cylinder(
            h = screw_hole_top_z - screw_hole_bottom_z,
            d = screw_diameter + screw_hole_extra_diameter 
        );
    }
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
) {
    delta = (end_point - start_point) / (num_screws_between + 1);

    if (inclusive_begin) {
        translate(start_point) {
            screw_hole(
                screw_diameter = screw_diameter,
                screw_hole_extra_diameter = screw_hole_extra_diameter,
                screw_hole_top_z = screw_hole_top_z,
                screw_hole_bottom_z = screw_hole_bottom_z
            );
        }
    }

    for (i = [1 : num_screws_between]) {
        translate(start_point + (delta * i)) {
            screw_hole(
                screw_diameter = screw_diameter,
                screw_hole_extra_diameter = screw_hole_extra_diameter,
                screw_hole_top_z = screw_hole_top_z,
                screw_hole_bottom_z = screw_hole_bottom_z
            );
        }
    }

    if (inclusive_end) {
        translate(end_point) {
            screw_hole(
                screw_diameter = screw_diameter,
                screw_hole_extra_diameter = screw_hole_extra_diameter,
                screw_hole_top_z = screw_hole_top_z,
                screw_hole_bottom_z = screw_hole_bottom_z
            );
        }
    }
}
