import unittest

from kicad_helpers.make_switch_plate import (
    DEFAULT_FACE_TEXT,
    DEFAULT_REPO_TEXT,
    MAX_TEXT_WIDTH_MM,
    below_switch_offset,
    fit_text,
    is_mount_ref,
    is_stab_ref,
    is_switch_ref,
    longest_line_chars,
    needs_stab,
    oriented_rect_corners,
    parse_switch_width_u,
    parse_xy,
    resolve_text_xy,
    rotate_offset,
    stacked_south,
    stab_centers,
    text_size_for_width,
    wrap_to_max_chars,
)


class TestParse(unittest.TestCase):
    def test_parse_xy(self):
        self.assertEqual(parse_xy("10,20"), (10.0, 20.0))
        self.assertEqual(parse_xy(" 10.5 , -3 "), (10.5, -3.0))

    def test_parse_xy_rejects_junk(self):
        with self.assertRaises(Exception):
            parse_xy("SW_1_1")

    def test_width_from_footprint_name(self):
        self.assertEqual(
            parse_switch_width_u("Switch_Keyboard_Cherry_MX:SW_Cherry_MX_PCB_2.00u"),
            2.0,
        )
        self.assertEqual(
            parse_switch_width_u("SW_Cherry_MX_PCB_1.00u"),
            1.0,
        )
        self.assertIsNone(parse_switch_width_u("ProjectLocal:SW_MX_PG1350_reversible"))

    def test_needs_stab(self):
        self.assertFalse(needs_stab(None))
        self.assertFalse(needs_stab(1.0))
        self.assertFalse(needs_stab(1.75))
        self.assertTrue(needs_stab(2.0))
        self.assertTrue(needs_stab(2.75))

    def test_refs(self):
        self.assertTrue(is_switch_ref("SW_1_1"))
        self.assertTrue(is_switch_ref("SW_4_12"))
        self.assertTrue(is_switch_ref("SW_11"))
        self.assertFalse(is_switch_ref("ST_1_1"))
        self.assertFalse(is_switch_ref("SW_RESET1"))
        self.assertFalse(is_switch_ref("SW_BOOT0"))
        self.assertTrue(is_stab_ref("ST_4_12"))
        self.assertTrue(is_mount_ref("H1"))
        self.assertTrue(is_mount_ref("H12"))
        self.assertFalse(is_mount_ref("H_M2"))
        self.assertFalse(is_mount_ref("HOLE_A"))


class TestGeometry(unittest.TestCase):
    def test_rotate_identity(self):
        self.assertEqual(rotate_offset(11.938, 1.5, 0), (11.938, 1.5))

    def test_rotate_90_sends_x_to_y(self):
        x, y = rotate_offset(10, 0, 90)
        self.assertAlmostEqual(x, 0.0, places=6)
        self.assertAlmostEqual(y, 10.0, places=6)

    def test_stab_centers_zero_deg(self):
        pts = stab_centers(0, 0, 0)
        self.assertEqual(len(pts), 2)
        xs = sorted(p[0] for p in pts)
        self.assertAlmostEqual(xs[0], -11.938)
        self.assertAlmostEqual(xs[1], 11.938)
        self.assertTrue(all(abs(p[1] - 1.5) < 1e-9 for p in pts))

    def test_oriented_rect_unrotated_is_axis_aligned(self):
        pts = oriented_rect_corners(0, 0, 7, 15, 0)
        xs = [p[0] for p in pts]
        ys = [p[1] for p in pts]
        self.assertAlmostEqual(min(xs), -3.5)
        self.assertAlmostEqual(max(xs), 3.5)
        self.assertAlmostEqual(min(ys), -7.5)
        self.assertAlmostEqual(max(ys), 7.5)


class TestText(unittest.TestCase):
    def test_default_face_text_fits_20mm_at_08(self):
        size = text_size_for_width(DEFAULT_FACE_TEXT, max_width_mm=20, max_size_mm=0.8)
        self.assertGreaterEqual(size, 0.8 - 1e-9)
        self.assertLessEqual(longest_line_chars(DEFAULT_FACE_TEXT) * size, 20 + 1e-9)

    def test_repo_text_is_shrunk_under_20mm(self):
        text, size = fit_text(DEFAULT_REPO_TEXT, max_width_mm=20, max_size_mm=0.8)
        self.assertEqual(text, DEFAULT_REPO_TEXT)
        self.assertLessEqual(len(DEFAULT_REPO_TEXT) * size, 20 + 1e-9)
        self.assertLess(size, 0.8)

    def test_wrap_long_line(self):
        wrapped = wrap_to_max_chars("this side faces towards the keyboard PCB", 20)
        self.assertTrue(all(len(line) <= 20 for line in wrapped.splitlines()))
        self.assertIn("keyboard", wrapped)

    def test_below_switch_is_south_of_cutout(self):
        dx, dy = below_switch_offset(14, 1.2)
        self.assertEqual(dx, 0.0)
        self.assertAlmostEqual(dy, 8.2)

    def test_stacked_south(self):
        self.assertEqual(stacked_south(10, 20, 2.0, 0.4), (10, 22.4))

    def test_resolve_absolute_wins(self):
        self.assertEqual(
            resolve_text_xy((1, 1), (9, 9), (0, 8), (0, 8)),
            (9, 9),
        )

    def test_resolve_offset(self):
        self.assertEqual(
            resolve_text_xy((57.5, 57.5), None, (0, 10), (0, 8.2)),
            (57.5, 67.5),
        )

    def test_resolve_default_offset(self):
        self.assertEqual(
            resolve_text_xy((57.5, 57.5), None, None, (0, 8.2)),
            (57.5, 65.7),
        )


if __name__ == "__main__":
    unittest.main()
