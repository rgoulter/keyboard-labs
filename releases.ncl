# Releases  -  structured source for GitHub releases
# Pattern: title, hero_image (top photo), intro (prose, wrapped), errata/changelog, photos, then assets.
# URLs are fine long; prose is wrapped to avoid one very long line.

let Photo = {
  url | String,
  caption | String,
} in
let StoreListing = {
  name | String,
  url | String,
} in
let Ibom = {
  url | String,
  label | String,
} in
let Release = {
  tag | String,
  title | String,
  hero_image | Photo | optional,
  intro | String,
  errata | String | optional,
  changelog | String | optional,
  photos | Array Photo | optional,
  pcb_renders | Array Photo | optional,
  design_goals | Array String | optional,
  board | Array String,
  rev | String,
  mcu | String | optional,
  form_factor | String | optional,
  store_listings | Array StoreListing | optional,
  gerber | Array String | optional,
  schematic | Array Dyn | optional,
  pcba | Array { bom | String | optional, cpl | String | optional } | optional,
  plates | Array String | optional,
  case_files | Array String | optional,
  firmware_bin | Array Dyn | optional,
  source_pcb | Array String | optional,
  source_sch | Array String | optional,
  firmware_board | String | optional,
  firmware_board_url | String | optional,
  firmware_repo | String | optional,
  firmware_fork | String | optional,
  firmware_config | String | optional,
  firmware_keymaps | Array { name | String, url | String } | optional,
  build_guide | Array String | optional,
  ibom | Array Ibom | optional,
} in
{
  releases = [
    import "releases/v2020.1.ncl",
    import "releases/v2021.1.ncl",
    import "releases/v2021.2-0303.ncl",
    import "releases/v2021.2.ncl",
    import "releases/v2021.3.ncl",
    import "releases/v2021.4.ncl",
    import "releases/x2-rev2021.1.ncl",
    import "releases/x1-rev2021.5.ncl",
    import "releases/x2-hsrgb-rev2022.1.ncl",
    import "releases/pykey40-lite-rev2023.3.ncl",
    import "releases/pico42-rev2023.1.ncl",
    import "releases/pico42-rev2023.2.ncl",
    import "releases/ch552_44-rev2023.1a.ncl",
    import "releases/ch552_48-rev2023.1.ncl",
    import "releases/ch552_44-rev2023.2.ncl",
    import "releases/iso-linux-environment.ncl",
    import "releases/ch552_36-rev2023.1.ncl",
    import "releases/pykey40-hsrgb-rev2023.1.ncl",
    import "releases/ch552_48_lpr-rev2023.1.ncl",
    import "releases/wabble-60-rev2024.2.ncl",
    import "releases/ch32x-48-rev2025.4.ncl",
    import "releases/ch32x-36-rev2025.1.ncl",
    import "releases/ch32x-75-lpr-rev2025.1.ncl",
    import "releases/ch32x-48-rev2025.2.ncl",
    import "releases/ch32x-60-improved-rev2026.1.ncl"
  ]
}
