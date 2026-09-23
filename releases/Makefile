# Releases - Nickel -> markdown/html via releases_render.py
# Make owns file-deps; just wraps it for UX.
# Usage: make -C releases md    (all markdown to ../build/releases-md)
#        make -C releases html  (all html to ../build/releases-html)
#        make -C releases ../build/releases-md/<tag>.md
#        make -C releases ../build/releases-html/<tag>.html

REPO_ROOT ?= $(abspath $(CURDIR)/..)
OUT_MD ?= ../build/releases-md
OUT_HTML ?= ../build/releases-html

NCL_SRCS := $(wildcard $(REPO_ROOT)/releases/*.ncl) $(REPO_ROOT)/releases.ncl
TEMPLATE := $(REPO_ROOT)/templates/release.md.j2
RENDER := $(REPO_ROOT)/scripts/releases_render.py

.PHONY: all
all: md html

.PHONY: md
md: $(OUT_MD)/.stamp

$(OUT_MD)/.stamp: $(NCL_SRCS) $(TEMPLATE) $(RENDER)
	mkdir -p $(OUT_MD)
	uv run --script $(RENDER) --all --format md --out $(OUT_MD)
	touch $@

# Single tag: build/releases-md/<tag>.md
$(OUT_MD)/%.md: $(NCL_SRCS) $(TEMPLATE) $(RENDER)
	mkdir -p $(@D)
	uv run --script $(RENDER) --tag $* --format md > $@

.PHONY: html
html: $(OUT_HTML)/.stamp

$(OUT_HTML)/.stamp: $(NCL_SRCS) $(TEMPLATE) $(RENDER)
	mkdir -p $(OUT_HTML)
	uv run --script $(RENDER) --all --format html --out $(OUT_HTML)
	touch $@

# Single tag: build/releases-html/<tag>.html
$(OUT_HTML)/%.html: $(NCL_SRCS) $(TEMPLATE) $(RENDER)
	mkdir -p $(@D)
	uv run --script $(RENDER) --tag $* --format html > $@

.PHONY: clean
clean:
	rm -rf $(OUT_MD) $(OUT_HTML)
