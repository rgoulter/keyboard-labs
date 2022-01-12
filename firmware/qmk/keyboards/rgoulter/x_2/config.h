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

// #include "config_common.h"

/* USB Device descriptor parameter */
#define VENDOR_ID 0xFEED
#define PRODUCT_ID 0x7813
#define DEVICE_VER 0x0001
#define MANUFACTURER Richard Goulter
#define PRODUCT X-2 Lumberjack-Arm


#define MATRIX_IO_DELAY 5
#define TAP_CODE_DELAY 10

/* Debounce reduces chatter (unintended double-presses) - set 0 if debouncing is not needed */
#define DEBOUNCE 5

/* disable these deprecated features by default */
#define NO_ACTION_MACRO
#define NO_ACTION_FUNCTION

/* key matrix size */
#define MATRIX_ROWS 5
#define MATRIX_COLS 12
#define DIODE_DIRECTION COL2ROW

// RGB Lighting
#ifdef RGBLIGHT_ENABLE
#define RGBLIGHT_ANIMATIONS

#define DRIVER_LED_TOTAL 4
#define RGBLED_NUM 4
#define RGBLIGHT_LED_MAP { 3, 2, 1, 0 }

#define RGBLIGHT_LIMIT_VAL 80
#endif
