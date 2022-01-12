/* Copyright 2019
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

// RGB Lighting
#ifdef RGBLIGHT_ENABLE
#define RGB_DI_PIN B0

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

#define MATRIX_COL_PINS { B12, B13, B14, B15, A8, A15, A3, A4, A5, A6, A7, B1 }
#define MATRIX_ROW_PINS { A10, B5, B6, B7, B8 }
#define UNUSED_PINS
