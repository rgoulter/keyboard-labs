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
#   Generates all the outputs defined in config.kibot.yaml:
#     $ ./docker-run-kibot.sh --board-file keyboard-100x100-minif4-dual-rgb-reversible.kicad_pcb
#
#   Generates the "pcbdraw_top" output defined in config.kibot.yaml.
#     $ ./docker-run-kibot.sh --board-file keyboard-100x100-minif4-dual-rgb-reversible.kicad_pcb pcbdraw_top
#
# ENVIRONMENT VARIABLES:
#  - KIBOT_IMAGE
#     default value: richardgoulter/kibot
#     The Docker image name used (excluding the Docker image tag).
#  - TAG:
#     default value: kicad-5
#     The tag used for the Docker image.

set -ex

USER_ID=$(id -u)
GROUP_ID=$(id -g)

# ensure the kicad cache and config directories exist.
KICAD_CACHE="${XDG_CACHE_HOME:-${HOME}/.cache}/kicad"
mkdir -p "${KICAD_CACHE}"

KICAD_CONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/kicad"
mkdir -p "${KICAD_CONFIG}"

# ensure the sym-lib-table is non-empty, so eeschema can run.
if [ ! -f "${KICAD_CONFIG}/sym-lib-table" ]; then
    cat > "${KICAD_CONFIG}/sym-lib-table" <<EOF
(sym_lib_table
)
EOF
fi

# path to this directory, from where the script was called.
SCRIPT_DIR="$(dirname $0)"

KIBOT_IMAGE="${IMAGE:-richardgoulter/kibot}"
TAG="${TAG:-kicad-5}"

(
  cd "${SCRIPT_DIR}"
  docker run \
      --rm \
      --interactive \
      --tty \
      --env NO_AT_BRIDGE=1 \
      --env DISPLAY=$DISPLAY \
      --volume=/tmp/.X11-unix:/tmp/.X11-unix \
      --user $USER_ID:$GROUP_ID \
      --volume="/etc/group:/etc/group:ro" \
      --volume="/etc/passwd:/etc/passwd:ro" \
      --volume="/etc/shadow:/etc/shadow:ro" \
      --volume="${KICAD_CONFIG}:${KICAD_CONFIG}:rw" \
      --volume="${KICAD_CACHE}:${KICAD_CACHE}:rw" \
      --volume=$(pwd):$(pwd) \
      --workdir="$(pwd)" \
      "${KIBOT_IMAGE}:${TAG}" \
      /bin/bash -c "kibot $*"
)
