kicad_pcbs := $(wildcard *.kicad_pcb)
boards := $(basename $(kicad_pcbs))

.PHONY: %-kibot
%-kibot:
	kibot --board-file "$*.kicad_pcb"

all: $(foreach board,$(boards),$(board)-kibot)