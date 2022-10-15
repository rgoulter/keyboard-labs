#!/usr/bin/env nix-shell
#!nix-shell -i bash shell-interactive-html-bom.nix

set -ex

SCRIPTS_DIR="$(dirname "$0")"
PCB_DIR="${SCRIPTS_DIR}/../pcb"

InteractiveHtmlBom \
  --checkboxes="" \
  --name-format="ibom-x1-minif4_36-rev%r" \
  --sort-order="R,C,C_,D_,D_BL_,Q,U,J,M,SW_BOOT,SW_RESET,SW_,SW_RE,H,~" \
  --extra-data-file="../pcb/keyboard-100x100-minif4-dual-rgb-reversible.net" \
  --extra-fields="Description,Comment" \
  --group-fields="Value" \
  --show-fields="References,Value,Description,Comment,Quantity" \
  --no-browser \
  "${PCB_DIR}/keyboard-100x100-minif4-dual-rgb-reversible.kicad_pcb"
