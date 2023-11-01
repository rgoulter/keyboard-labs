.PHONY: all
all:

.PHONY: clean
clean:

keyboard_case-threads.png: keyboard_case-threads.scad
	openscad \
	  ./keyboard_case-threads.scad \
	  --o=keyboard_case-threads.png \
	  --projection=ortho \
	  --camera=114,-44,0,0,0,0,280 \
	  --imgsize=2048,900

%.csg: %.scad
	openscad $< --render -o $@
