#!/usr/bin/env bash

# USAGE:
#   ./run-kibot.sh <args to kibot>
#
#   DWIM wrapper:
#    tries Apple Container first
#    (if `container` CLI installed and `container system status` reports running),
#   otherwise falls back to Docker.
#
#   For explicit control, use container-run-kibot.sh or docker-run-kibot.sh.
#
#   All args are forwarded to kibot. See config.kibot.yaml for available
#   outputs; pcba_bom/pcba_position are run_by_default: false so must be named:
#     $ ./run-kibot.sh --board-file keyboard-ch32x-48.kicad_pcb pcba_bom pcba_position
#
# ENVIRONMENT VARIABLES:
#   KIBOT_IMAGE, TAG - see container-run-kibot.sh / docker-run-kibot.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

_detect_backend() {
  if command -v container >/dev/null 2>&1; then
    if container system status >/dev/null 2>&1; then
      if container system status 2>/dev/null | grep -q "status.*running"; then
        echo "container"
        return 0
      fi
    fi
  fi
  if command -v docker >/dev/null 2>&1; then
    echo "docker"
    return 0
  fi
  echo "none"
}

# Prefer native kibot when available (no container needed)
if command -v kibot >/dev/null 2>&1; then
  exec kibot "$@"
fi

backend=$(_detect_backend)
if [ "$backend" = "container" ]; then
  exec "${SCRIPT_DIR}/container-run-kibot.sh" "$@"
elif [ "$backend" = "docker" ]; then
  exec "${SCRIPT_DIR}/docker-run-kibot.sh" "$@"
else
  echo "error: neither 'container' (running) nor 'docker' found" >&2
  echo "  install Apple Container (https://github.com/apple/container) or Docker Desktop/colima" >&2
  exit 1
fi
