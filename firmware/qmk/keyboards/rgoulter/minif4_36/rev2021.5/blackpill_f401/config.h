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

#define DIRECT_PINS {               \
    { B12,    B15, A9,  A5,  B3  }, \
    { B13,    A8,  A10, A15, B10 }, \
    { B14,    B1,  A6,  A4,  B5  }, \
    { NO_PIN, A7,  A2,  A0,  C13 }  \
}

// Rotary Encoders
#ifdef ENCODER_ENABLE
#define ENCODERS_PAD_A { A3 }
#define ENCODERS_PAD_B { B4 }
#endif

// RGB Matrix
#ifdef RGB_MATRIX_ENABLE
#define RGB_DI_PIN B0

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
