kicad_pcbs := $(wildcard *.kicad_pcb)
boards := $(basename $(kicad_pcbs))

ibom_targets := $(foreach board,$(boards),$(board)-ibom)
kibot_targets := $(foreach board,$(boards),$(board)-kibot)

.PHONY: all
all: $(kibot_targets) $(ibom_targets)

.PHONY: %-kibot
%-kibot:
	kibot --board-file "$*.kicad_pcb"

.PHONY: demo-usb-16pin-ibom
demo-usb-16pin-ibom:
	true

.PHONY: keyboard-100x100-minif4-dual-rgb-reversible-ibom
keyboard-100x100-minif4-dual-rgb-reversible-ibom:
	bash ../scripts/generate-x1-ibom-basic.sh
	bash ../scripts/generate-x1-ibom.sh

.PHONY: keyboard-x2-lumberjack-arm-ibom
keyboard-x2-lumberjack-arm-ibom:
	bash ../scripts/generate-x2-ibom.sh

.PHONY: keyboard-x2-lumberjack-arm-hsrgb-ibom
keyboard-x2-lumberjack-arm-hsrgb-ibom:
	bash ../scripts/generate-x2-hsrgb-ibom.sh


