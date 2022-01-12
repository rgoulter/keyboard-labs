/* Copyright 2021 Richard Goulter
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

#include "minif4_36.h"

#ifdef SPLIT_KEYBOARD
#include "split_util.h"
#endif

#if defined(RGB_MATRIX_ENABLE)
#ifdef SPLIT_KEYBOARD
led_config_t g_led_config = {
  {
   // Key Matrix to LED Index

   // LHS
   { 0, 1, 2, 3, 4 },
   { 5, 6, 7, 8, 9 },
   { 10, 11, 12, 13, 14 },
   { NO_LED, NO_LED, 15, 16, 17 },
   // 18, 19, 20, 21 are underneath

   // RHS
   { 22, 23, 24, 25, 26 },
   { 27, 28, 29, 30, 31 },
   { 32, 33, 34, 35, 36 },
   { NO_LED, NO_LED, 37, 38, 39 },
   // 40, 41, 42, 43 are underneath
  },
  {
   // LED Index to Physical Position

   // very rough approximation
   // LHS:
   { 10, 10 }, { 35, 10 }, { 70, 10 }, { 95, 10 }, { 120, 10 },
   { 10, 60 }, { 35, 60 }, { 70, 60 }, { 95, 60 }, { 120, 60 },
   { 10, 110 }, { 35, 110 }, { 70, 110 }, { 95, 110 }, { 120, 110 },
   { 70, 160 }, { 95, 160 }, { 120, 160 },
   { 100, 190 }, { 30, 190 }, { 30, 60 }, { 100, 60 },

   // RHS:
   { 230, 10 }, { 205, 10 }, { 180, 10 }, { 155, 10 }, { 130, 10 },
   { 230, 60 }, { 205, 60 }, { 180, 60 }, { 155, 60 }, { 130, 60 },
   { 230, 110 }, { 205, 110 }, { 180, 110 }, { 155, 110 }, { 130, 110 },
   { 230, 160 }, { 205, 160 }, { 180, 160 },
   { 190, 190 }, { 130, 190 }, { 130, 60 }, { 190, 60 }
  },
  {
   // LED Index to Flag
   4, 4, 4, 4, 4,
   4, 4, 4, 4, 4,
   4, 4, 4, 4, 4,
   1, 1, 1,
   2, 2, 2,
   
   4, 4, 4, 4, 4,
   4, 4, 4, 4, 4,
   4, 4, 4, 4, 4,
   1, 1, 1,
   2, 2, 2
  }
};
#else
led_config_t g_led_config = {
  {
   // Key Matrix to LED Index

   // LHS
   { 0, 1, 2, 3, 4 },
   { 5, 6, 7, 8, 9 },
   { 10, 11, 12, 13, 14 },
   { NO_LED, NO_LED, 15, 16, 17 },
   // 18, 19, 20, 21 are underneath
  },
  {
   // LED Index to Physical Position

   // very rough approximation
   // LHS:
   { 10, 10 }, { 35, 10 }, { 70, 10 }, { 95, 10 }, { 120, 10 },
   { 10, 60 }, { 35, 60 }, { 70, 60 }, { 95, 60 }, { 120, 60 },
   { 10, 110 }, { 35, 110 }, { 70, 110 }, { 95, 110 }, { 120, 110 },
   { 70, 160 }, { 95, 160 }, { 120, 160 },
   { 100, 190 }, { 30, 190 }, { 30, 60 }, { 100, 60 },
  },
  {
   // LED Index to Flag
   4, 4, 4, 4, 4,
   4, 4, 4, 4, 4,
   4, 4, 4, 4, 4,
   1, 1, 1,
   2, 2, 2
  }
};
#endif
#endif

void board_init(void) {
    // B9 is configured as I2C1_SDA in the board file; that function must be
    // disabled before using B7 as I2C1_SDA.
    setPinInputHigh(B9);
}

void matrix_init_kb(void) {
#ifdef RGB_MATRIX_ENABLE
#ifdef SPLIT_KEYBOARD
    if (!is_keyboard_left()) {
        g_led_config = (led_config_t){
          {
           // Key Matrix to LED Index

           // RHS
           { 22, 23, 24, 25, 26 },
           { 27, 28, 29, 30, 31 },
           { 32, 33, 34, 35, 36 },
           { NO_LED, NO_LED, 37, 38, 39 },
           // 40, 41, 42, 43 are underneath

           // LHS
           { 0, 1, 2, 3, 4 },
           { 5, 6, 7, 8, 9 },
           { 10, 11, 12, 13, 14 },
           { NO_LED, NO_LED, 15, 16, 17 },
           // 18, 19, 20, 21 are underneath
          },
          {
           // LED Index to Physical Position

           // very rough approximation
           // RHS:
           { 230, 10 }, { 205, 10 }, { 180, 10 }, { 155, 10 }, { 130, 10 },
           { 230, 60 }, { 205, 60 }, { 180, 60 }, { 155, 60 }, { 130, 60 },
           { 230, 110 }, { 205, 110 }, { 180, 110 }, { 155, 110 }, { 130, 110 },
           { 230, 160 }, { 205, 160 }, { 180, 160 },
           { 190, 190 }, { 130, 190 }, { 130, 60 }, { 190, 60 },

           // LHS:
           { 10, 10 }, { 35, 10 }, { 70, 10 }, { 95, 10 }, { 120, 10 },
           { 10, 60 }, { 35, 60 }, { 70, 60 }, { 95, 60 }, { 120, 60 },
           { 10, 110 }, { 35, 110 }, { 70, 110 }, { 95, 110 }, { 120, 110 },
           { 70, 160 }, { 95, 160 }, { 120, 160 },
           { 100, 190 }, { 30, 190 }, { 30, 60 }, { 100, 60 }
          },
          {
           // LED Index to Flag
           4, 4, 4, 4, 4,
           4, 4, 4, 4, 4,
           4, 4, 4, 4, 4,
           1, 1, 1,
           2, 2, 2,
           
           4, 4, 4, 4, 4,
           4, 4, 4, 4, 4,
           4, 4, 4, 4, 4,
           1, 1, 1,
           2, 2, 2
          }
        };
    }
#endif
#endif
    matrix_init_user();
}
// */
