ifeq ($(strip $(PINKIELESS_LAYOUT)), yes)
    OPT_DEFS += -DPINKIELESS_LAYOUT
endif

SRC += rgoulter.c
