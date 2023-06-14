/* Copyright 2020
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

// RGB Matrix
#ifdef RGB_MATRIX_ENABLE

#ifdef SPLIT_KEYBOARD
// 18 + 4 on each side
#define DRIVER_LED_TOTAL 44
#define RGB_MATRIX_LED_COUNT 44
#define RGB_MATRIX_SPLIT { 22,22 }
#else
#define DRIVER_LED_TOTAL 22
#define RGB_MATRIX_LED_COUNT 22
#endif

#define RGB_MATRIX_KEYPRESSES

#endif

// OLED
#ifdef OLED_ENABLE
/* B8, B9 instead of B6, B7 */
#define I2C1_SCL_PIN B8
#define I2C1_SDA_PIN B9
#endif
