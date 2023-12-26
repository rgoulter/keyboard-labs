// Copyright 2023 Richard Goulter
// SPDX-License-Identifier: GPL-2.0-or-later

#pragma once

#ifdef OLED_ENABLE
#define HAL_USE_I2C TRUE
#endif

#ifdef RGB_MATRIX_ENABLE
#define HAL_USE_PWM TRUE
#endif

#ifdef SPLIT_KEYBOARD
#define PAL_USE_CALLBACKS TRUE
#define PAL_USE_WAIT TRUE
#endif

#include_next <halconf.h>
