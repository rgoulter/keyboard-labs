kicad_pcbs := $(wildcard *.kicad_pcb)
boards := $(basename $(kicad_pcbs))

ibom_targets := $(foreach board,$(boards),$(board)-ibom)
kibot_targets := $(foreach board,$(boards),$(board)-kibot)

.PHONY: all
all: $(kibot_targets) iboms

.PHONY: iboms
iboms: $(ibom_targets)

.PHONY: %-kibot
%-kibot:
	kibot --board-file "$*.kicad_pcb"

.PHONY: demo-usb-16pin-ibom
demo-usb-16pin-ibom:
	true

%.net:
	kibot --board-file "$*.kicad_pcb" netlist

.PHONY: keyboard-100x100-minif4-dual-rgb-reversible-ibom
keyboard-100x100-minif4-dual-rgb-reversible-ibom: keyboard-100x100-minif4-dual-rgb-reversible.net
	bash ../scripts/generate-x1-ibom-basic.sh
	bash ../scripts/generate-x1-ibom.sh

.PHONY: keyboard-x2-lumberjack-arm-ibom
keyboard-x2-lumberjack-arm-ibom: keyboard-x2-lumberjack-arm.net
	bash ../scripts/generate-x2-ibom.sh

.PHONY: keyboard-x2-lumberjack-arm-hsrgb-ibom
keyboard-x2-lumberjack-arm-hsrgb-ibom: keyboard-x2-lumberjack-arm-hsrgb.net
	bash ../scripts/generate-x2-hsrgb-ibom.sh

.PHONY: keyboard-pykey40-lite-ibom
keyboard-pykey40-lite-ibom:
	true

.PHONY: keyboard-pico42-ibom
keyboard-pico42-ibom: keyboard-pico42.net
	bash ../scripts/generate-pico42-ibom.sh

.PHONY: keyboard-ch552-44-ibom
keyboard-ch552-44-ibom: keyboard-ch552-44.net
	bash ../scripts/generate-ch552-44-ibom.sh
