include <keyboard_case-constants.scad>;

// rounds the edge along the z axis.
module round_z_edge(r, height, eps = 0.01) {
    eps2 = eps * 2;
    eps4 = eps2 * 2;
    translate([-eps, -eps, -eps]) {
        difference() {
            cube([r + eps, r + eps, height + eps2], center = false);
            translate([r + eps, r + eps, -eps]) {
                cylinder(h = height + eps4, r = r);
            }
        }
    }
}

// rounds the edge along the y axis.
module round_y_edge(r, length, eps = 0.01) {
    rotate([-90, 0, 0]) {
        round_z_edge(r = r, height = length);
    }
}

module corner_cutouts(dim, r, height) {
    width = dim[0];
    length = dim[1];

    rotate([0, 0, 0]) {
        round_z_edge(r = r, height = height);
    }
    translate([width, 0]) {
        rotate([0, 0, 90]) {
            round_z_edge(r = r, height = height);
        }
    }
    translate([width, length]) {
        rotate([0, 0, 180]) {
            round_z_edge(r = r, height = height);
        }
    }
    translate([0, length]) {
        rotate([0, 0, 270]) {
            round_z_edge(r = r, height = height);
        }
    }
}

module chamfer_cutouts(r, dim, corner_r) {
    width = dim[0];
    length = dim[1];

    dz = sqrt(2) * r / 2;

    translate([dz, 0, -dz]) {
        rotate([45, 0, 0]) {
            cube([width - (2 * dz), r, r]);
        }
    }
    translate([r, length, -dz]) {
        rotate([45, 0, 0]) {
            cube([width - (2 * r), r, r]);
        }
    }
    translate([-dz, dz, 0]) {
        rotate([0, 45, 0]) {
            cube([r, length - (2 * dz), r]);
        }
    }
    translate([-dz + width, r, 0]) {
        rotate([0, 45, 0]) {
            cube([r, length - (2 * r), r]);
        }
    }

    difference() {
        cube([2*corner_r, 2*corner_r, 2*dz], center = true);

        translate([corner_r, corner_r, -dz]) cylinder(r1 = corner_r, r2 = 0, h = corner_r);
    }
    translate([width, 0, 0]) {
        rotate(90) {
            difference() {
                cube([2*corner_r, 2*corner_r, 2*dz], center = true);
                translate([corner_r, corner_r, -dz]) cylinder(r1 = corner_r, r2 = 0, h = corner_r);
            }
        }
    }
    translate([width, length, 0]) {
        rotate(180) {
            difference() {
                cube([2*corner_r, 2*corner_r, 2*dz], center = true);
                translate([corner_r, corner_r, -dz]) cylinder(r1 = corner_r, r2 = 0, h = corner_r);
            }
        }
    }
    translate([0, length, 0]) {
        rotate(270) {
            difference() {
                cube([2*corner_r, 2*corner_r, 2*dz], center = true);
                translate([corner_r, corner_r, -dz]) cylinder(r1 = corner_r, r2 = 0, h = corner_r);
            }
        }
    }
}

// origin = middle of front face
module rounded_box(
  w,
  l,
  h,
  r
) {
    translate([-(w / 2), l, -(h / 2)]) {
        rotate([90, 0, 0]) {
            difference() {
                cube([w, h, l], center = false);
                corner_cutouts(dim = [w, h], r = r, height = l);
            }
        }
    }
}

// for the pcb, with some padding
module pcb_cavity(
  dim,
  r,
  height,
  eps = 0.01
) {
    translate([0, 0, -height]) {
        difference() {
            cube([dim[0], dim[1], height + eps], center = false);
            corner_cutouts(dim = dim, r = r, height = height);
        }
    }
}

// Cutout from the bottom of the case.
//
// origin is at the USB connector's mid-x, along the edge of the case, at the bottom of the PCB.
module usb_connector_cutout(
    width,
    length,
    height,
    // distance from top of USB-C connector, to top of the cutout.
    z_offset,
    corner_r,
) {
    translate([-(width / 2), 0, z_offset - height]) {
        difference() {
            cube([width, length + 0.01, height + 0.01], center = false);

            translate([0, length, 0]) {
                rotate([0, 0, 270]) {
                    round_z_edge(r = corner_r, height = height);
                }
            }
            translate([width, length, 0]) {
                rotate([0, 0, 180]) {
                    round_z_edge(r = corner_r, height = height);
                }
            }
        }

        translate([0.01, 0, 0]) {
            rotate([0, 0, 90]) {
                round_z_edge(r = corner_r, height = height, eps = 0);
            }
        }
        translate([width -0.01, 0, 0]) {
            rotate([0, 0, 0]) {
                round_z_edge(r = corner_r, height = height, eps = 0);
            }
        }
    }
}
// Cutout for USB Connector port.
//
// origin is at the USB connector's mid-x, along the edge of the case, at the bottom of the PCB.
module usb_connector_port_cutout(
    width,
    length,
    height,
    corner_r,
) {
    usb_connector_height = 4;
    translate([0, 0, -(usb_connector_height / 2)]) {
        rounded_box(
            w = width,
            l = length + 0.1,
            h = height,
            r = corner_r
        );
    }
}

// origin is the mid-x, top, front of the cutout.
module devboard_connector_access_cutout(
    width,
    length,
    height,
    corner_r
) {
    translate([-(width / 2), -0.005, -height]) {
        difference() {
            cube([width, length + 0.01, height + 0.01], center = false);


            translate([0, 0, 0]) {
                rotate([0, 270, 0]) {
                    round_y_edge(r = corner_r, length = length);
                }
            }
            translate([width, 0, 0]) {
                rotate([0, 180, 0]) {
                    round_y_edge(r = corner_r, length = length);
                }
            }
        }


        translate([0.01, 0, height]) {
            rotate([0, 90, 0]) {
                round_y_edge(r = corner_r, length = length);
            }
        }
        translate([width -0.01, 0, height]) {
            rotate([0, 0, 0]) {
                round_y_edge(r = corner_r, length = length);
            }
        }
    }
}

module countersunk_foot_hole(
    height,
    dia = 4, // the hole for the M4 screws.
    countersink_dia = 8, // M4
    countersink_angle = 90,
    foot_dia = 22 // the aluminum feet for GH-60 style cases.
) {
    countersink_r = countersink_dia / 2;
    countersink_height = countersink_r / tan(countersink_angle / 2);
    translate([0, 0, -countersink_height]) {
        cylinder(h = countersink_height, d1 = 0, d2 = countersink_dia);
    }
    translate([0, 0, -height - 0.1]) {
        if ($preview) %circle(d = foot_dia);
        cylinder(h = height + 0.1, d = dia);
    }
}

module simple_keyboard_case(
    pcb_sw_1_1_position = PCB_SW_1_1_POSITION,
    pcb_mounting_hole_offsets = PCB_MOUNTING_HOLE_OFFSETS,
    switch_plate_dim = SWITCH_PLATE_DIM,
    switch_plate_pcb_position = SWITCH_PLATE_PCB_POSITION,
    case_switch_plate_margin = CASE_SWITCH_PLATE_MARGIN,
    case_wall_thickness = CASE_WALL_THICKNESS,
    case_bottom_height = CASE_BOTTOM_HEIGHT,
    case_outer_corner_r = 3,
    cavity_upper_height = CASE_LOW_PROFILE_MX_UPPER_CAVITY_HEIGHT,
    upper_cavity_r = 2,
    cavity_lower_height = CASE_LOWER_CAVITY_HEIGHT,
    lower_cavity_r = 4,
    chamfer_edges = true,
    mount_hole_post_dia = 6,
    mount_thread_hole_tapping_dia = 1.6, // M2 pilot dia
    // thread length should be < 3x diameter.
    mount_thread_hole_threaded_height = 2.4,
    // For blind holes,
    //  recommended to have extra length unthreaded.
    mount_thread_hole_threaded_extra_height = 1.6,
    cutout_feet_holes = true,
    foot_offset = [16, 12],
    foot_hole_dia = 4, // the hole for the M4 screws.
    foot_hole_countersink_dia = 8, // M4
    cutout_usb_connector = true,
    pcb_usb_connector_mid_x = PCB_USB_CONNECTOR_MID_X,
    usb_port_style = "bottom",
    usb_connector_hole_width = 12,
    usb_connector_hole_height = 8,
    usb_connector_cutout_length = 7, // y-axis
    usb_connector_cutout_corner_r = 1,
    cutout_devboard_connector_access = false,
    devboard_connector_access_width = 2 * SWITCH_GRID_UNIT,
    devboard_connector_access_corner_r = 2,
    // distance between top of keyboard PCB, bottom of devboard
    devboard_mounted_height = 0,
    pcb_thickness = 1.6,
    devboard_pcb_thickness = 1,
    cutout_bumpon_guides = true,
    case_bumpon_guide_positions = CASE_BUMPON_GUIDE_POSITIONS,
    bumpon_guide_height = 0.5,
    bumpon_guide_dia = 8.1
) {
    scale([1, -1, 1]) {
        pcb_cavity_dim = switch_plate_dim + (case_switch_plate_margin * [2, 2]);

        // case outer dim roughly [240, 87, 12]
        case_outer_width = case_wall_thickness + pcb_cavity_dim[0] + case_wall_thickness;
        case_outer_length = case_wall_thickness + pcb_cavity_dim[1] + case_wall_thickness;
        case_outer_height = cavity_upper_height + cavity_lower_height + case_bottom_height;

        echo(case_outer_width = case_outer_width, case_outer_length = case_outer_length, case_outer_height = case_outer_height);

        case_cavity_position = [case_wall_thickness, case_wall_thickness];
        cavity_pcb_position = [case_switch_plate_margin, case_switch_plate_margin] + switch_plate_pcb_position;
        case_pcb_position = case_cavity_position + cavity_pcb_position;

        pcb_mounting_hole_positions = [
            for (offset = pcb_mounting_hole_offsets) pcb_sw_1_1_position + offset
        ];

        usb_connector_height = 4;

        difference() {
            cube([case_outer_width, case_outer_length, case_outer_height]);

            // from the max cube, cut...

            // - corners
            corner_cutouts(r = case_outer_corner_r, dim = [case_outer_width, case_outer_length], height = case_outer_height);

            translate([0, 0, case_outer_height]) {
                // - cut out cavity for PCB (2 layers)
                //   - but leave some posts for the mounting holes
                translate(case_cavity_position) {
                    // lower cavity; drill out more space,
                    //  except for the posts for mounting holes.
                    difference() {
                        union() {
                            pcb_cavity(
                                dim = pcb_cavity_dim,
                                r = upper_cavity_r,
                                height = cavity_upper_height
                            );
                            translate([0, 0, -cavity_upper_height]) {
                                pcb_cavity(
                                    dim = pcb_cavity_dim,
                                    r = lower_cavity_r,
                                    height = cavity_lower_height
                                );
                            }
                        }

                        // cutout mounting posts from the cavity cutouts.
                        // (i.e. leave some material for the mounting posts).
                        translate(cavity_pcb_position) {
                            translate([0, 0, -cavity_upper_height - cavity_lower_height + 0.01]) {
                                for (pt = pcb_mounting_hole_positions) {
                                    translate(pt) {
                                        cylinder(h = cavity_lower_height, d = mount_hole_post_dia);
                                    }
                                }
                            }
                        }
                    }
                }

                // - holes for the pcb mounting threads
                translate(case_pcb_position) {
                    mount_thread_hole_height = mount_thread_hole_threaded_height + mount_thread_hole_threaded_extra_height;
                    translate([0, 0, -cavity_upper_height - mount_thread_hole_height]) {
                        for (pt = pcb_mounting_hole_positions) {
                            translate(pt) {
                                cylinder(h = mount_thread_hole_height + (2 * 0.01), d = mount_thread_hole_tapping_dia);
                            }
                        }
                    }
                }

                // - holes for the feet, and their countersinks
                if (cutout_feet_holes) {
                    foot_offset_x = foot_offset[0];
                    foot_offset_y = foot_offset[1];
                    foot_hole_height = case_bottom_height;
                    translate([0, foot_offset_y, -cavity_upper_height - cavity_lower_height + 0.01]) {
                        for (foot_hole_pt = [[foot_offset_x, 0], [case_outer_width - foot_offset_x, 0]]) {
                            translate(foot_hole_pt) {
                                countersunk_foot_hole(
                                    height = foot_hole_height,
                                    dia = foot_hole_dia,
                                    countersink_dia = foot_hole_countersink_dia
                                );
                            }
                        }
                    }
                }

                // - hole for the USB connector
                if (cutout_usb_connector) {
                    case_usb_connector_mid_x = case_pcb_position[0] + pcb_usb_connector_mid_x;
                    translate([case_usb_connector_mid_x, -0.01, - 0.01 - cavity_upper_height]) {
                        if (usb_port_style == "bottom") {
                            // height from bottom of the case.
                            // board is mounted above the 'pcb cavity2';
                            // but also needs to have enough height for USB connectors.
                            usb_connector_margin_above = (usb_connector_hole_height / 2) - (usb_connector_height / 2);
                            usb_connector_cutout_height = case_bottom_height + cavity_lower_height + usb_connector_margin_above; // 12 - 3.5 or 12 - 4
                            usb_connector_z = case_outer_height - usb_connector_cutout_height;
                            z_offset = cavity_upper_height - usb_connector_z;

                            usb_connector_cutout(
                                width = usb_connector_hole_width,
                                length = usb_connector_cutout_length,
                                height  = usb_connector_cutout_height,
                                z_offset = z_offset,
                                corner_r = usb_connector_cutout_corner_r
                            );
                        }
                        if (usb_port_style == "port") {
                            usb_connector_port_cutout(
                                width = usb_connector_hole_width,
                                length = case_wall_thickness,
                                height  = usb_connector_hole_height,
                                corner_r = usb_connector_cutout_corner_r
                            );
                        }
                    }
                }

                // - cutout to access devboard connector
                //   (for lumberjack-style cases)
                if (cutout_devboard_connector_access) {
                    devboard_connector_access_height = cavity_upper_height - pcb_thickness - devboard_pcb_thickness - devboard_mounted_height - (usb_connector_height / 2) + (usb_connector_hole_height / 2);

                    translate([case_outer_width / 2, 0, 0]) {
                        devboard_connector_access_cutout(
                            width = devboard_connector_access_width,
                            length = case_wall_thickness,
                            height = devboard_connector_access_height,
                            corner_r = devboard_connector_access_corner_r
                        );
                    }
                }

                // - chamfer the edges
                if (chamfer_edges) {
                    chamfer_cutouts(r = 0.5, dim = [case_outer_width, case_outer_length], corner_r = case_outer_corner_r);

                    translate([0, 0, -case_outer_height]) {
                        scale([1, 1, -1]) {
                            chamfer_cutouts(r = 0.5, dim = [case_outer_width, case_outer_length], corner_r = case_outer_corner_r);
                        }
                    }
                }
            }

            // - small indents for bumpons
            if (cutout_bumpon_guides) {
                for (bumpon_guide_pt_wrapped = case_bumpon_guide_positions) {
                    // allow 'wrapping around' the height,
                    // so that the parameter is easier to set.
                    bumpon_guide_pt = [bumpon_guide_pt_wrapped[0], bumpon_guide_pt_wrapped[1] < 0 ? case_outer_length + bumpon_guide_pt_wrapped[1] : bumpon_guide_pt_wrapped[1]];
                    translate([bumpon_guide_pt[0], bumpon_guide_pt[1], -0.01]) {
                        cylinder(h = bumpon_guide_height, d = bumpon_guide_dia);
                    }
                    translate([case_outer_width - bumpon_guide_pt[0], bumpon_guide_pt[1], -0.01]) {
                        cylinder(h = bumpon_guide_height, d = bumpon_guide_dia);
                    }
                }
            }
        }

        if ($preview) {
            translate(case_pcb_position) {
                translate([0, 0, case_bottom_height + cavity_lower_height]) {
                    children();
                }
            }
        }
    }
}

$fn = 64;
simple_keyboard_case();
