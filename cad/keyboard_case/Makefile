SCAD_3DP_FILES := $(filter-out 3dp-constants.scad,$(wildcard 3dp-*.scad))
STL_3DP_FILES := $(patsubst %.scad,%.stl,$(SCAD_3DP_FILES))

.PHONY: all
all: 3dp

.PHONY: clean
clean:
	rm -f *.csg *.stl

.PHONY: 3dp
3dp: $(STL_3DP_FILES)

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
