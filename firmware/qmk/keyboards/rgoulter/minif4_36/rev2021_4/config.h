/* Copyright 2021
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

#define DIRECT_PINS { \
   { B15, A8, A9, A10, A2 },       \
   { B5, A15, B3, B4, B10 },       \
   { A1, B1, B0, A7, A6 },         \
   { NO_PIN, B14, A5, A4, A3 }     \
}

// Rotary Encoders
#ifdef ENCODER_ENABLE
#define ENCODERS_PAD_A { B12 }
#define ENCODERS_PAD_B { B13 }
// RE switch is B14
#endif

// RGB Matrix
#ifdef RGB_MATRIX_ENABLE
#define WS2812_DI_PIN A0

// cf. Table 9. Alternate function mapping
// of STM32F401xE datasheet
// PA0's AF_02 is TIM5_CH1
#define WS2812_PWM_DRIVER PWMD5
#define WS2812_PWM_CHANNEL 1
#define WS2812_PWM_PAL_MODE 2
// cf. Table 28. DMA1 request mapping
// in 9.3.3 of RM0368
#define WS2812_DMA_STREAM STM32_DMA1_STREAM0
#define WS2812_DMA_CHANNEL 6
#endif
