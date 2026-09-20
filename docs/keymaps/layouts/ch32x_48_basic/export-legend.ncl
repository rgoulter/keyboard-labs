let E = import "export-legend-lib.ncl" in
let km =
  (import "../tests/ncl/keymap-48key-basic/keymap.ncl")
  & (import "keymap-ncl-to-json.ncl")
in
E.bundle_of "tests/ncl/keymap-48key-basic/keymap.ncl" km.layers_of_keys
