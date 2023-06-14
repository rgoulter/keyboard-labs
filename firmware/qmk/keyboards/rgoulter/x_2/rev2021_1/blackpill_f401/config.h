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
