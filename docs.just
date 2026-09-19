# MkDocs Material — local preview and build
#
# Tailnet preview (from another machine on Tailscale):
#   just docs::serve
#   then open http://gaming-pc:8000/keyboard-labs/docs/
#   (site_url uses the /keyboard-labs/docs/ prefix to match gh-pages)

[doc("install mkdocs-material into .venv via uv")]
install:
    #!/usr/bin/env bash
    set -euo pipefail
    uv venv .venv
    uv pip install --python .venv/bin/python -r requirements-docs.txt

[doc("serve on 0.0.0.0:8000 for Tailscale / LAN preview")]
serve:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ ! -x .venv/bin/mkdocs ]]; then
      just docs::install
    fi
    echo "Listening on 0.0.0.0:8000 (Tailscale: http://$(hostname -s):8000/keyboard-labs/docs/ )"
    .venv/bin/mkdocs serve --dev-addr 0.0.0.0:8000

[doc("build static site into ./site")]
build:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ ! -x .venv/bin/mkdocs ]]; then
      just docs::install
    fi
    .venv/bin/mkdocs build --strict
