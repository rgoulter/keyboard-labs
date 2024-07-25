#!/usr/bin/env nix-shell
#!nix-shell -i bash ../pcb/shell.nix
# shellcheck shell=bash

set -ex

SCRIPTS_DIR="$(dirname "$0")"
PCB_DIR="${SCRIPTS_DIR}/../pcb"
BOARD="keyboard-wabble-60"

InteractiveHtmlBom \
  --checkboxes="" \
  --name-format="ibom-${BOARD}-rev%r" \
  --sort-order="C,D,J,Q,R,SW,U,D_,SW_,H,~" \
  --extra-data-file="../pcb/${BOARD}.net" \
  --extra-fields="Description,Comment" \
  --group-fields="Value" \
  --show-fields="References,Value,Description,Comment,Quantity" \
  --no-browser \
  --blacklist="HOLE" \
  "${PCB_DIR}/${BOARD}.kicad_pcb"
