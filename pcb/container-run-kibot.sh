#!/usr/bin/env bash

# USAGE:
#   ./container-run-kibot.sh <args to kibot>
#
#   Convenience script for running Kibot using Apple Container
#    (macOS 26+ Tahoe, `container` CLI from https://github.com/apple/container).
#
# USAGE EXAMPLES:
#   Generates all the default outputs (gerbers, docs) per config.kibot.yaml:
#     $ ./container-run-kibot.sh --board-file keyboard-100x100-minif4-dual-rgb-reversible.kicad_pcb
#
#   Generates JLC PCBA files (BOM + CPL): false in config:
#     $ ./container-run-kibot.sh --board-file keyboard-ch32x-48.kicad_pcb pcba_bom pcba_position
#     $ ./container-run-kibot.sh --board-file keyboard-ch32x-36-lhs.kicad_pcb pcba_bom pcba_position
#     $ ./container-run-kibot.sh --board-file keyboard-ch32x-36-rhs.kicad_pcb pcba_bom pcba_position
#
# ENVIRONMENT VARIABLES:
#  - KIBOT_IMAGE
#     default value: ghcr.io/inti-cmnb/kicad10_auto
#  - TAG
#     default value: latest (e.g. 1.9.1, latest)

set -e
[ -n "${VERBOSE:-}" ] && set -x

# ensure the kicad cache and config directories exist.
KICAD_CACHE="${XDG_CACHE_HOME:-${HOME}/.cache}/kicad"
mkdir -p "${KICAD_CACHE}"

KICAD_CONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/kicad"
mkdir -p "${KICAD_CONFIG}"

# ensure the sym-lib-table is non-empty, so eeschema can run.
if [ ! -f "${KICAD_CONFIG}/sym-lib-table" ]; then
  cat >"${KICAD_CONFIG}/sym-lib-table" <<EOF
(sym_lib_table
)
EOF
fi

# path to this directory, from where the script was called.
SCRIPT_DIR="$(dirname "${0}")"

KIBOT_IMAGE="${IMAGE:-${KIBOT_IMAGE:-ghcr.io/inti-cmnb/kicad10_auto}}"
TAG="${TAG:-latest}"

(
  cd "${SCRIPT_DIR}"
  container run \
    --rm \
    --platform linux/amd64 \
    --volume "$(pwd):$(pwd)" \
    --volume "${KICAD_CONFIG}:${KICAD_CONFIG}" \
    --volume "${KICAD_CACHE}:${KICAD_CACHE}" \
    --workdir "$(pwd)" \
    "${KIBOT_IMAGE}:${TAG}" \
    kibot "$@"
)
