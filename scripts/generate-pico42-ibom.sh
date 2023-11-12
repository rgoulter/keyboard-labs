#!/usr/bin/env nix-shell
#!nix-shell -i bash ../pcb/shell.nix
# shellcheck shell=bash

set -ex

SCRIPTS_DIR="$(dirname "$0")"
PCB_DIR="${SCRIPTS_DIR}/../pcb"
BOARD="keyboard-pico42"

InteractiveHtmlBom \
  --checkboxes="" \
  --name-format="ibom-${BOARD}-rev%r" \
  --sort-order="R,C,C_,D_,D_BL_,Q,U,J,M,SW_BOOT,SW_RESET,SW_,SW_RE,H,~" \
  --extra-data-file="../pcb/${BOARD}.net" \
  --extra-fields="Description" \
  --group-fields="Value" \
  --show-fields="References,Value,Description,Quantity" \
  --no-browser \
  "${PCB_DIR}/${BOARD}.kicad_pcb"
