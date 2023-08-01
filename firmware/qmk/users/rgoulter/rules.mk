ifeq ($(strip $(PINKIELESS_LAYOUT)), yes)
    OPT_DEFS += -DPINKIELESS_LAYOUT
endif

ifeq ($(strip $(CORNER_RESET_ENABLE)), yes)
    OPT_DEFS += -DCORNER_RESET_ENABLE
endif

SRC += rgoulter.c
