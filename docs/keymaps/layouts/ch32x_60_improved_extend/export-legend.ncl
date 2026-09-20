let E = import "export-legend-lib.ncl" in
let km =
  (import "../tests/ncl/keymap-66key-extend/keymap.ncl")
  & (import "keymap-ncl-to-json.ncl")
in
let numbered = km.layers_of_keys in
let named = km.named_layers in
let named_rows =
  std.record.fields named
  |> std.array.map (fun name =>
    km.layer_as_array_of_keys (std.record.get name named)
  )
in
let layer_rows = numbered @ named_rows in
E.bundle_of "tests/ncl/keymap-66key-extend/keymap.ncl" layer_rows
