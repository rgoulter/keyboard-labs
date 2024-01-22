scads := \
  jj40_pcb_outline.scad \
  pico42_pcb_outline.scad \
  ch552-48-lpr_pcb_outline.scad \
  jj40_bottom_plate.scad \
  jj40_bottom_plate_pcb.scad  \
  ch552-48-lpr_bottom_plate.scad \
  ch552-44_switch_plate.scad \
  jj40_switch_plate-ortho_4x12.scad \
  jj40_switch_plate.scad \
  pico42_switch_plate.scad
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
