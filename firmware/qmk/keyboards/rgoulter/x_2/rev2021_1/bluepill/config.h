// Copyright 2023 Richard Goulter
// SPDX-License-Identifier: GPL-2.0-or-later

#pragma once

// RGB Lighting
#ifdef RGBLIGHT_ENABLE

// Per the STM32F103x8 Datasheet,
// Bluepill
// PB1 has AF (default) TIM3_CH4
#define WS2812_PWM_DRIVER PWMD3
#define WS2812_PWM_CHANNEL 4
// #define WS2812_PWM_PAL_MODE 2
// Per RM0008, section 13.3.7,
// Figure 50 shows TIM3_UP on "HW request 3".
// Table 78 shows TIM3_UP on Channel 3.
#define WS2812_DMA_STREAM STM32_DMA1_STREAM3
#define WS2812_DMA_CHANNEL 3
#endif

#ifdef RGB_MATRIX_ENABLE

// Per the STM32F103x8 Datasheet,
// Bluepill
// PB1 has AF (default) TIM3_CH4
#define WS2812_PWM_DRIVER PWMD3
#define WS2812_PWM_CHANNEL 4
// #define WS2812_PWM_PAL_MODE 2
// Per RM0008, section 13.3.7,
// Figure 50 shows TIM3_UP on "HW request 3".
// Table 78 shows TIM3_UP on Channel 3.
#define WS2812_DMA_STREAM STM32_DMA1_STREAM3
#define WS2812_DMA_CHANNEL 3
#endif
