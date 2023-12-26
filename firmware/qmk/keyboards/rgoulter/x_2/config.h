// Copyright 2023 Richard Goulter
// SPDX-License-Identifier: GPL-2.0-or-later

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
