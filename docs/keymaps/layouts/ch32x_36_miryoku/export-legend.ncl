let E = import "export-legend-lib.ncl" in
let km =
  (import "../tests/ncl/keymap-36key-miryoku/keymap.ncl")
  & (import "keymap-ncl-to-json.ncl")
in
E.bundle_of "tests/ncl/keymap-36key-miryoku/keymap.ncl" km.layers_of_keys
