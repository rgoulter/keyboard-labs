## Keyboard Case

A set of OpenScad files for a parameterised simple keyboard case design.

I've used these for CNC milling, as well as for 3D printing.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/openscad-keyboard_case.png" width=600 />

### Generating `.step` Files

For CNC machining, I used a `.step` file. I generated the `.step` file by:

- Exporting `.csg` from the OpenScad file.

- Opening the `.csg` in FreeCad.

- Selecting the root object, and exporting this to `.step`.
