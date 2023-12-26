// Copyright 2023 Richard Goulter
// SPDX-License-Identifier: GPL-2.0-or-later

#pragma once

#ifdef RGBLIGHT_ENABLE
#define HAL_USE_PWM TRUE
#endif

#ifdef RGB_MATRIX_ENABLE
#define HAL_USE_PWM TRUE
#endif

#include_next <halconf.h>
