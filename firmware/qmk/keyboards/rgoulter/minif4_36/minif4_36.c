// Copyright 2023 Richard Goulter
// SPDX-License-Identifier: GPL-2.0-or-later

#include "minif4_36.h"

#ifdef SPLIT_KEYBOARD
#include "split_util.h"
#endif

void board_init(void) {
    // B9 is configured as I2C1_SDA in the board file; that function must be
    // disabled before using B7 as I2C1_SDA.
    setPinInputHigh(B9);
}
