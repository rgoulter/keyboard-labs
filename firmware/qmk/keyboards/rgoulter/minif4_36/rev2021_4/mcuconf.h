// Copyright 2023 Richard Goulter
// SPDX-License-Identifier: GPL-2.0-or-later

#pragma once

#include_next <mcuconf.h>

#ifdef OLED_ENABLE
#undef STM32_I2C_USE_I2C1
#define STM32_I2C_USE_I2C1 TRUE

#ifdef RGB_MATRIX_ENABLE
// The default DMA1 stream used in mcuconf.h
// collides with the A0 AF02 DMA1 usage.
#undef STM32_I2C_I2C1_RX_DMA_STREAM
#define STM32_I2C_I2C1_RX_DMA_STREAM        STM32_DMA_STREAM_ID(1, 5)
#endif

#endif

#ifdef RGB_MATRIX_ENABLE
#undef STM32_PWM_USE_TIM5
#define STM32_PWM_USE_TIM5 TRUE
#endif
