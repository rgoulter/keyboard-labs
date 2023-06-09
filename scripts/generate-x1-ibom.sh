#!/usr/bin/env nix-shell
#!nix-shell -i bash ../pcb/shell.nix
# shellcheck shell=bash

set -ex

SCRIPTS_DIR="$(dirname "$0")"
PCB_DIR="${SCRIPTS_DIR}/../pcb"
BOARD="keyboard-100x100-minif4-dual-rgb-reversible"

InteractiveHtmlBom \
  --checkboxes="" \
  --name-format="ibom-${BOARD}-rev%r" \
  --sort-order="R,C,C_,D_,D_BL_,Q,U,J,M,SW_BOOT,SW_RESET,SW_,SW_RE,H,~" \
  --extra-fields="Description,Comment" \
  --group-fields="Value" \
  --show-fields="References,Value,Description,Comment,Quantity" \
  --no-browser \
  "${PCB_DIR}/${BOARD}.kicad_pcb"
