# MCU name
MCU = STM32F401

# https://docs.qmk.fm/#/flashing
BOOTLOADER = tinyuf2
# BOOTLOADER = stm32-dfu

WS2812_DRIVER = pwm
OPT_DEFS += -DSTM32_DMA_REQUIRED=TRUE
