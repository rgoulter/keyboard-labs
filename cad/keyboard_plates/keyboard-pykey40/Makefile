scads := \
  jj40_bottom_plate.scad \
  jj40_pcb_outline.scad \
  jj40_bottom_plate_pcb.scad  \
  jj40_switch_plate.scad
plates := $(basename $(scads))
svgs := $(foreach plate,$(plates),$(plate).svg)
dxfs := $(foreach plate,$(plates),$(plate).dxf)

.PHONY: all
all: $(svgs) $(dxfs) pico42_switch_plate

.PHONY: clean
clean:
	rm *.dxf *.svg

pico42_switch_plate.dxf: jj40_switch_plate.scad
	openscad $< -D render_plate=2 -o $@

pico42_switch_plate.svg: jj40_switch_plate.scad
	openscad $< -D render_plate=2 -o $@

.PHONY: pico42_switch_plate
pico42_switch_plate: pico42_switch_plate.dxf pico42_switch_plate.svg

%.dxf: %.scad
	openscad $< -o $@

%.svg: %.scad
	openscad $< -o $@
