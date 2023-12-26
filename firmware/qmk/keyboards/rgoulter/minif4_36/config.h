// Copyright 2023 Richard Goulter
// SPDX-License-Identifier: GPL-2.0-or-later

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


#ifdef SPLIT_KEYBOARD
#ifdef HAPTIC_ENABLE
#define SPLIT_HAPTIC_ENABLE
#endif
#endif
