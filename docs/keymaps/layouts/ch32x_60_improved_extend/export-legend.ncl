let E = import "export-legend-lib.ncl" in
let km =
  (import "../tests/ncl/keymap-66key-extend/keymap.ncl")
  & (import "keymap-ncl-to-json.ncl")
in
let numbered = km.layers_of_keys in
# Named rows in engine order so wash indices match named_layer_indices.
let named_rows =
  km.named_layer_names
  |> std.array.map (fun name =>
    km.layer_as_array_of_keys (std.record.get name km.named_layers)
  )
in
let layer_rows = numbered @ named_rows in
E.bundle_of_with_index "tests/ncl/keymap-66key-extend/keymap.ncl" layer_rows km.named_layer_indices
