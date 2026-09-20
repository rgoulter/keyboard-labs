# MkDocs Material — local preview and build
#
# Tailnet preview (serve is at the server root; site_url is only set in CI):
#   just docs::serve
#   then open http://<host>:8000/

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
    echo "Listening on 0.0.0.0:8000 — open http://$(hostname -s):8000/"
    .venv/bin/mkdocs serve --dev-addr 0.0.0.0:8000

[doc("build static site into ./site")]
build:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ ! -x .venv/bin/mkdocs ]]; then
      just docs::install
    fi
    .venv/bin/mkdocs build --strict
