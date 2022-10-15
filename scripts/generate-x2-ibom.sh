#!/usr/bin/env nix-shell
#!nix-shell -i bash shell-interactive-html-bom.nix
# shellcheck shell=bash

set -ex

SCRIPTS_DIR="$(dirname "$0")"
PCB_DIR="${SCRIPTS_DIR}/../pcb"

InteractiveHtmlBom \
  --checkboxes="" \
  --name-format="ibom-x2-lumberjack-arm-rev%r" \
  --sort-order="R,C,C_,D_,D_BL_,Q,U,J,M,SW_BOOT,SW_RESET,SW_,SW_RE,H,~" \
  --blacklist="HOLE" \
  --extra-data-file="../pcb/keyboard-x2-lumberjack-arm.net" \
  --extra-fields="Description,Comment" \
  --group-fields="Value" \
  --show-fields="References,Value,Description,Comment,Quantity" \
  --no-browser \
  "${PCB_DIR}/keyboard-x2-lumberjack-arm.kicad_pcb"
