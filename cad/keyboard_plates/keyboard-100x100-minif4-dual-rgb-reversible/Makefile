scads := \
  plate-x1_rev2021.5.scad
plates := $(basename $(scads))
svgs := $(foreach plate,$(plates),$(plate).svg)
dxfs := $(foreach plate,$(plates),$(plate).dxf)

.PHONY: all
all: $(svgs) $(dxfs)

.PHONY: clean
clean:
	rm -f $(dxfs) $(svgs)

%.dxf: %.scad
	openscad $< -o $@

%.svg: %.scad
	openscad $< -o $@
