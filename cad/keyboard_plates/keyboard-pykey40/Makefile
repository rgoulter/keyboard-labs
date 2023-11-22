scads := \
  jj40_bottom_plate.scad \
  jj40_pcb_outline.scad \
  jj40_bottom_plate_pcb.scad  \
  jj40_switch_plate.scad
plates := $(basename $(scads))
svgs := $(foreach plate,$(plates),$(plate).svg)
dxfs := $(foreach plate,$(plates),$(plate).dxf)

.PHONY: all
all: $(svgs) $(dxfs) pico42_pcb_outline-usb.dxf

.PHONY: clean
clean:
	rm *.dxf *.svg

pico42_pcb_outline-usb.dxf: pico42_pcb_outline.scad
	openscad $< -D include_usb_connector=true -o $@

%.dxf: %.scad
	openscad $< -o $@

%.svg: %.scad
	openscad $< -o $@
