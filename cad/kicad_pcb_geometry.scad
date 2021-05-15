// Returns the list with the first item dropped
// e.g. tail([4,5,6]) == [5,6]
function tail(a) =
    is_list(a) ?
        [
            for (i = [1 : len(a) - 1])
                a[i]
        ]
    :
        undef;
function list_contains(xs, needle) =
    len([for (i = xs) if (i == needle) true]) > 0;

// Returns the tail of a list in the assoc_list
// if the element begins with the key.
//
// e.g. kicad_alist_lookup(["sym", ["x", 4, 5], ["y", 6, 7]], "y") == [6, 7]
function kicad_alist_lookup(assoc_list, key) = [
    for (item = assoc_list)
        if (is_list(item) && item[0] == key)
            tail(item)
][0];

module line(start_point, end_point, width) {
    let (
        dx = end_point[0] - start_point[0],
        dy = end_point[1] - start_point[1]
    ) {
        translate(start_point) {
            hull() {
                circle(d = width); // start point
                translate([dx, dy]) {
                    circle(d = width); // end point
                }
            }
        }
    }
};

module arc(start_point, end_point, arc_angle, width) {
    let (
        dx = end_point[0] - start_point[0],
        dy = end_point[1] - start_point[1],
        arc_len = sqrt((dx * dx) + (dy * dy)),
        init_angle = atan2(dy, dx),
        fn = 60,
        da = arc_angle / (fn - 1)
    ) {
        translate(start_point) {
            for(i = [1 : fn - 1]) {
                let(
                    angle = init_angle + (da * (i - 1)),
                    angle_next = angle + da
                ) {
                    hull() {
                        rotate(angle) {
                            translate([(arc_len), 0]) {
                                circle(d = width);
                            }
                        }
                        rotate(angle_next) {
                            translate([(arc_len), 0]) {
                                circle(d = width);
                            }
                        }
                    }
                }
            }
        }
    }
};

/*
 * EDGE CUTS
 *
 * e.g.:
 * edge_cuts_data = [
 *   ["line", ["start", 0, 0], ["end", 100, 0], ["width", 0.05]],
 *   ["line", ["start", 0, 0], ["end", 0, 100], ["width", 0.05]],
 *   ["line", ["start", 0, 100], ["end", 100, 100], ["width", 0.05]],
 *   ["line", ["start", 100, 0], ["end", 100, 100], ["width", 0.05]],
 * ];
 */

module edge_cuts_shape(edge_cuts_data) {
    for (edge_cut = edge_cuts_data) {
        edge_cut_kind = edge_cut[0];

        if (edge_cut_kind == "line") {
            start_point = kicad_alist_lookup(edge_cut, "start");
            end_point = kicad_alist_lookup(edge_cut, "end");
            width = kicad_alist_lookup(edge_cut, "width")[0];

            line(start_point, end_point, width);
        } else if (edge_cut_kind == "arc") {
            start_point = kicad_alist_lookup(edge_cut, "start");
            end_point = kicad_alist_lookup(edge_cut, "end");
            arc_angle = kicad_alist_lookup(edge_cut, "angle")[0];
            width = kicad_alist_lookup(edge_cut, "width")[0];

            arc(start_point, end_point, arc_angle, width);
        }
    }
}

// A hull() around the edge_cuts_shape of
// the edge_cuts_data. Convenient for
// PCBs with a convex hull shape.
module board_outline(edge_cuts_data) {
    hull() {
        edge_cuts_shape(edge_cuts_data);
    }
}

// Union of the module footprints from modules_data.
//
// e.g. modules_data:
//  modules_datax = [
//    [
//      "Footprint_SW_MX",
//      ["at", 30, 30],
//      ["reference", "SW_11"]
//    ],
//    [
//      "Footprint_SW_MX",
//      ["at", 70, 30],
//      ["reference", "SW_12"]
//    ],
//    [
//      "Footprint_Devboard",
//      ["at", 0, 90, 90],
//      ["reference", "U1"]
//    ],
//    [
//      "Footprint_TRRS_Jack",
//      ["at", 97, 70, 270],
//      ["reference", "U1"]
//    ],
//  ];
//
// want some way to include/exclude;
// e.g.
// - include_footprint - if empty, all included; if non-empty, only those,
// - exclude_footprint - don't show any with those footprints, unless reference included,
// - exclude_reference_prefixes - don't show if reference has any of these as prefix,
// - exclude_reference - don't show with this reference,
// - force_include_reference - show reference, even if otherwise not included
module module_footprints(
    modules_data,
    include_footprints = undef,
    exclude_footprints = [],
    exclude_reference_prefixes = ["C", "D", "Q", "R", "TP"],
    exclude_references = [],
    force_include_references = [],
    allow_unhandled_footprints = true,
    allow_unimplemented_footprints = true
) {
    for (module_data = modules_data) {
        module_footprint = module_data[0];
        module_at_pos = kicad_alist_lookup(module_data, "at");
        module_reference = kicad_alist_lookup(module_data, "reference")[0];
        is_front_side = kicad_alist_lookup(module_data, "side")[0] == "front";

        x = module_at_pos[0];
        y = module_at_pos[1];

        // OpenScad and KiCad don't agree 
        kicad_rotation = module_at_pos[2] ? module_at_pos[2] : 0;
        openscad_rotation = [0, 0, -kicad_rotation];

        use_module = (
            // use module if...
            (
             // the include_footprints is empty (i.e. use all footprints)
             // or explicitly listed, and...
             (is_undef(include_footprints) ||
              list_contains(include_footprints, module_footprint)) &&
             // the footprint is not excluded, and ...
             !list_contains(exclude_footprints, module_footprint) &&
             // the reference doesn't have a prefix which is excluded, and ...
             !(len([ for (pre = exclude_reference_prefixes) if (search(pre, module_reference) == [0]) pre ]) > 0) &&
             // the reference is not excluded
             !list_contains(exclude_references, module_reference)
            ) ||
            // ... or, if the reference is included (highest precedence).
            list_contains(force_include_references, module_reference)
        );

        if (use_module) {
            translate([x, y]) {
                scale([is_front_side ? 1 : -1, 1, 1]) {
                    rotate(openscad_rotation) {
                        module_for_footprint(
                            module_data = module_data,
                            allow_unhandled_footprints = allow_unhandled_footprints,
                            allow_unimplemented_footprints = allow_unimplemented_footprints
                        );
                    }
                }
            }
        }
    }
}

module corner_rounder(r = 5) {
    difference() {
        square(r, center = false);
        translate([r, r]) {
            circle(r = r);
        }
    }
}

module plate(
    edge_cuts_data,
    modules_data,
    include_footprints = undef,
    exclude_footprints = undef,
    exclude_reference_prefixes = undef,
    exclude_references = undef,
    force_include_references = undef,
    allow_unhandled_footprints = true
) {
    // Invert the y-axis, since Kicad has y+ pointing "down",
    // but OpenSCAD has y+ pointing "up".
    scale([1, -1]) {
        difference() {
            board_outline(edge_cuts_data);
            module_footprints(
                modules_data = modules_data,
                include_footprints = include_footprints,
                exclude_footprints = exclude_footprints,
                exclude_reference_prefixes = exclude_reference_prefixes,
                exclude_references = exclude_references,
                force_include_references = force_include_references,
                allow_unhandled_footprints = allow_unhandled_footprints
            );
        }
    }
}
