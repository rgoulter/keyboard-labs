#!/usr/bin/env bash

# USAGE:
#   ./docker-run-kibot.sh <args to kibot>
#
#   Convenience script for running Kibot using a Docker image.
#
#   Runs kibot in a Docker container, mounting the pcb/ directory
#   with the current user's uid/gid.
#   Ensurers Kicad directories exist (on host) sufficient to run.
#
# USAGE EXAMPLES:
#   Generates all the default outputs (gerbers, docs) per config.kibot.yaml:
#     $ ./docker-run-kibot.sh --board-file keyboard-100x100-minif4-dual-rgb-reversible.kicad_pcb
#
#   Generates the "pcbdraw_top" output defined in config.kibot.yaml:
#     $ ./docker-run-kibot.sh --board-file keyboard-100x100-minif4-dual-rgb-reversible.kicad_pcb pcbdraw_top
#
#   Generates JLC PCBA files (BOM + CPL):
#     $ ./docker-run-kibot.sh --board-file keyboard-ch32x-48.kicad_pcb pcba_bom pcba_position
#     $ ./docker-run-kibot.sh --board-file keyboard-ch32x-36-lhs.kicad_pcb pcba_bom pcba_position
#
# ENVIRONMENT VARIABLES:
#  - KIBOT_IMAGE
#     default value: ghcr.io/inti-cmnb/kicad10_auto
#     The Docker image name used (excluding the Docker image tag).
#  - TAG:
#     default value: latest
#     The tag used for the Docker image (e.g. 1.9.1, latest).

set -e
[ -n "${VERBOSE:-}" ] && set -x

USER_ID=$(id -u)
GROUP_ID=$(id -g)

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
  docker run \
    --rm \
    --interactive \
    --tty \
    --platform linux/amd64 \
    --env "NO_AT_BRIDGE=1" \
    --env "DISPLAY=$DISPLAY" \
    --env "HOME=/tmp" \
    --volume=/tmp/.X11-unix:/tmp/.X11-unix \
    --user "$USER_ID:$GROUP_ID" \
    --volume="${KICAD_CONFIG}:${KICAD_CONFIG}:rw" \
    --volume="${KICAD_CACHE}:${KICAD_CACHE}:rw" \
    --volume="$(pwd):$(pwd)" \
    --workdir="$(pwd)" \
    "${KIBOT_IMAGE}:${TAG}" \
    kibot "$@"
)
