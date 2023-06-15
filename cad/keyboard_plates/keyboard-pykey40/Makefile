scads := $(wildcard *.scad)
plates := $(basename $(scads))
svgs := $(foreach plate,$(plates),$(plate).svg)
dxfs := $(foreach plate,$(plates),$(plate).dxf)

.PHONY: all
all: $(svgs) $(dxfs)

%.dxf %.svg: %.scad
	openscad $< -o $@
