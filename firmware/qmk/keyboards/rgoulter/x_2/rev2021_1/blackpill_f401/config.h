// Copyright 2023 Richard Goulter
// SPDX-License-Identifier: GPL-2.0-or-later

#pragma once

// RGB Lighting
#ifdef RGBLIGHT_ENABLE

// Per the STM32F401CE Datasheet,
// PB0 has AF02 TIM3_CH3
#define WS2812_PWM_DRIVER PWMD3
#define WS2812_PWM_CHANNEL 3
#define WS2812_PWM_PAL_MODE 2
// Per RM0368, section 9.3.3,
// Table 28 shows TIM3_UP on DMA1, Stream 2, Channel 5.
#define WS2812_DMA_STREAM STM32_DMA1_STREAM2
#define WS2812_DMA_CHANNEL 5
#endif

// RGB Matrix
#ifdef RGB_MATRIX_ENABLE

// Per the STM32F401CE Datasheet,
// PB0 has AF02 TIM3_CH3
#define WS2812_PWM_DRIVER PWMD3
#define WS2812_PWM_CHANNEL 3
#define WS2812_PWM_PAL_MODE 2
// Per RM0368, section 9.3.3,
// Table 28 shows TIM3_UP on DMA1, Stream 2, Channel 5.
#define WS2812_DMA_STREAM STM32_DMA1_STREAM2
#define WS2812_DMA_CHANNEL 5
#endif
