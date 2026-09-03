#!/usr/bin/env bash
#
# choose-board.sh - pick a pcb board, via fzf if available
# Usage: choose-board.sh [--prompt "pcb fab> "] [--ibom-only]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

prompt="pcb> "

ibom_only=false

# Process command line args
while [ $# -gt 0 ]; do
    case "$1" in
        --prompt) prompt="$2"; shift 2 ;;
        --ibom-only) ibom_only=true; shift ;;
        *) echo "unknown arg: $1" >&2; exit 1 ;;
    esac
done

# If fzf unavailable, print appropriately.
if ! command -v fzf >/dev/null 2>&1; then
    echo "Available boards:" >&2
    if $ibom_only; then
        grep -E '^[a-z0-9._-]+-ibom' "$SCRIPT_DIR/Makefile" 2>/dev/null \
            | sed -E 's/:.*//' \
            | sed 's/^/  /' >&2 \
            || true
    else
        ls "$SCRIPT_DIR"/*.kicad_pcb 2>/dev/null \
            | xargs -n1 basename -s .kicad_pcb \
            | sort \
            | sed 's/^/  /' >&2 \
            || true
    fi
    echo "Usage: just pcb::fab <board> (or install fzf)" >&2
    exit 1
fi

# List per if ibom only or not, and choose with FZF
if $ibom_only; then
    avail=$(
        grep -E '^[a-z0-9._-]+-ibom' "$SCRIPT_DIR/Makefile" 2>/dev/null \
            | sed -E 's/:.*//' \
            | sed 's/-ibom//' \
            | sort -u \
        || true
    )
    if [ -z "$avail" ]; then
        avail=$(
            ls "$SCRIPT_DIR"/*.kicad_pcb 2>/dev/null \
                | xargs -n1 basename -s .kicad_pcb \
                | sort
        )
    fi
    echo "$avail" | fzf --prompt="$prompt" --height=40% --reverse || true
else
    ls "$SCRIPT_DIR"/*.kicad_pcb 2>/dev/null \
        | xargs -n1 basename -s .kicad_pcb \
        | sort \
        | fzf --prompt="$prompt" --height=40% --reverse \
    || true
fi
