# Root justfile — UX wrappers around Make (Make still owns file-deps)
# Usage: `just --list`, `just --choose` (fzf), `just pcb::kibot <board>`, etc.

mod pcb
mod firmware
mod cad
mod nix

# default: interactive chooser if available, else list
default:
    @if command -v fzf >/dev/null 2>&1; then \
        just --choose; \
    else \
        echo "tip: install fzf for interactive chooser (just --choose)"; \
        just --list --list-submodules; \
    fi

# list all recipes including submodules
[doc("list all recipes")]
list:
    @just --list --list-submodules

# treefmt (nix fmt)
[doc("format all files (treefmt)")]
fmt:
    @if command -v treefmt >/dev/null 2>&1; then treefmt; else nix fmt; fi

[doc("check formatting without writing")]
fmt-check:
    @if command -v treefmt >/dev/null 2>&1; then treefmt --fail-on-change; else nix fmt -- --fail-on-change; fi

[doc("nix flake check (pcb + firmware builds)")]
check:
    nix flake check --show-trace
