/* Copyright 2020 Thys de Wet
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


/* USB Device descriptor parameter */
#define VENDOR_ID 0xFEED
#define PRODUCT_ID 0x7812
#define DEVICE_VER 0x0001
#define MANUFACTURER Richard Goulter
#define PRODUCT MiniF4 36-key

/* key matrix size */
// #define MATRIX_ROWS 8
#define MATRIX_ROWS 8
#define MATRIX_COLS 5

#define DIRECT_PINS { \
   { B15, A8, A9, A10, A2 },       \
   { B5, A15, B3, B4, B10 },       \
   { A1, B1, B0, A7, A6 },             \
   { NO_PIN, B14, A5, A4, A3 }          \
}

// #define MATRIX_COL_PINS { B0, A7, A3, A5, A4, A2 }
// #define MATRIX_ROW_PINS { B12, A6, B13, B9, B8 }
// #define MATRIX_COL_PINS_RIGHT { B0, A7, A3, A5, A4, A2 }
// #define MATRIX_ROW_PINS_RIGHT  { B12, A6, B13, B9, B8 }

#define SOFT_SERIAL_PIN B6
#define SPLIT_TRANSPORT_MIRROR

#define MATRIX_IO_DELAY 5
#define TAP_CODE_DELAY 10

#define ENCODERS_PAD_A { B12 }
#define ENCODERS_PAD_B { B13 }
// switch is B14

#define RGB_DI_PIN A0
// 18 + 4 on each side
#define DRIVER_LED_TOTAL 44

// #define RGBLED_NUM 44
// #define RGBLIGHT_SPLIT
// #define RGBLED_SPLIT { 22,22 }
// #define RGBLIGHT_LIMIT_VAL 128
// #define RGBLIGHT_ANIMATIONS

#define RGB_MATRIX_SPLIT { 22,22 }
#define RGB_MATRIX_MAXIMUM_BRIGHTNESS 200
#define RGB_MATRIX_KEYPRESSES

#define BOARD_OTG_NOVBUSSENS 1

#define WS2812_PWM_DRIVER PWMD5
#define WS2812_PWM_CHANNEL 1
#define WS2812_PWM_PAL_MODE 2
#define WS2812_DMA_STREAM STM32_DMA1_STREAM0
#define WS2812_DMA_CHANNEL 6

#define ENCODERS_PAD_A { B12 }
#define ENCODERS_PAD_B { B13 }

/* Debounce reduces chatter (unintended double-presses) - set 0 if debouncing is not needed */
#define DEBOUNCE 5


/* disable these deprecated features by default */
#define NO_ACTION_MACRO
#define NO_ACTION_FUNCTION

/* B8, B9 instead of B6, B7 */
#define I2C1_SCL 8
#define I2C1_SDA 9

/* B6, B7 instead of A9, A10 */
// #define SD1_TX_PIN B6
// #define SD1_RX_PIN B7
