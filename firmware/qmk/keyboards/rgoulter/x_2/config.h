/* Copyright 2020 Thys de Wet
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#pragma once

// RGB Lighting
#ifdef RGBLIGHT_ENABLE
#define DRIVER_LED_TOTAL 4
#define RGBLED_NUM 4
#define RGBLIGHT_LIMIT_VAL 80
#define RGBLIGHT_DEFAULT_VAL 30
#define RGBLIGHT_VAL_STEP 8
#endif

#ifdef RGB_MATRIX_ENABLE
#define DRIVER_LED_TOTAL 70
#define RGBLED_NUM 70
#define RGB_MATRIX_LED_COUNT 70
#define RGB_MATRIX_KEYPRESSES
#endif

#ifdef RGB_MATRIX_ENABLE
#ifdef RGBLIGHT_ENABLE
#error "rgblight and rgb_matrix both enabled"
#endif
#endif
