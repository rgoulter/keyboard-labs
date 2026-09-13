SCAD_3DP_FILES := $(filter-out 3dp-constants.scad,$(wildcard 3dp-*.scad))
STL_3DP_FILES := $(patsubst %.scad,%.stl,$(SCAD_3DP_FILES))

PYTHON ?= python3

.PHONY: all
all: 3dp

.PHONY: clean
clean:
	rm -f *.csg *.stl *.step

.PHONY: 3dp
3dp: $(STL_3DP_FILES)

.PHONY: case-pykey40-check
case-pykey40-check:
	$(PYTHON) case_pykey40.py --check

.PHONY: case-pykey40
case-pykey40:
	$(PYTHON) case_pykey40.py

keyboard_case-threads.png: keyboard_case-threads.scad
	openscad \
	  ./keyboard_case-threads.scad \
	  --o=keyboard_case-threads.png \
	  --projection=ortho \
	  --camera=114,-44,0,0,0,0,280 \
	  --imgsize=2048,900

%.csg: %.scad
	openscad $< --render -o $@

%.stl: %.scad
	openscad $< --render -o $@
