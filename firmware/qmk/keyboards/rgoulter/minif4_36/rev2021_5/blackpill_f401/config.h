// Copyright 2023 Richard Goulter
// SPDX-License-Identifier: GPL-2.0-or-later

#pragma once

// RGB Matrix
#ifdef RGB_MATRIX_ENABLE
// cf. Table 9. Alternate function mapping
// of STM32F401xE datasheet
// PB0's AF_02 is TIM3_CH3
#define WS2812_PWM_DRIVER PWMD3
#define WS2812_PWM_CHANNEL 3
#define WS2812_PWM_PAL_MODE 2
// cf. Table 28. DMA1 request mapping
// in 9.3.3 of RM0368
#define WS2812_DMA_STREAM STM32_DMA1_STREAM2
#define WS2812_DMA_CHANNEL 5
#endif

#ifdef HAPTIC_ENABLE
#define SOLENOID_PIN A1
#endif
