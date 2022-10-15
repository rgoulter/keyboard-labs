#!/usr/bin/env bash
#!nix-shell -i bash

set -ex

SCRIPTS_DIR="$(dirname "$0")"
PCB_DIR="${SCRIPTS_DIR}/../pcb"

python transform_kicadpcb_to_scad.py \
  --kicad_pcb_path "${PCB_DIR}/keyboard-x2-lumberjack-arm.kicad_pcb"
