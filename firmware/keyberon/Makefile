TARGET_DIR := target/thumbv7em-none-eabihf
DEBUG_TARGET_DIR ?= $(TARGET_DIR)/debug
RELEASE_TARGET_DIR ?= $(TARGET_DIR)/release
DEST_DIR ?= .
BINARIES := $(notdir $(basename $(wildcard src/bin/*.rs)))
BINARIES_BIN := $(addsuffix .bin,$(BINARIES))
BINARIES_UF2 := $(addsuffix .uf2,$(BINARIES))
EXAMPLES := $(notdir $(basename $(wildcard examples/*.rs)))
EXAMPLES_BIN := $(addprefix example-, $(addsuffix .bin,$(EXAMPLES)))
EXAMPLES_UF2 := $(addprefix example-, $(addsuffix .uf2,$(EXAMPLES)))
TARGETS = $(BINARIES) $(EXAMPLES)
TARGETS_BIN = $(BINARIES_BIN) $(EXAMPLES_BIN)
TARGETS_UF2 = $(BINARIES_UF2) $(EXAMPLES_UF2)

.PHONY: all
all: targets.bin targets.uf2

.PHONY: clean
clean: clean.bin clean.uf2

.PHONY: clean.bin
clean.bin:
	rm -f $(addprefix $(DEST_DIR)/,$(TARGETS_BIN))

.PHONY: clean.uf2
clean.uf2:
	rm -f $(addprefix $(DEST_DIR)/,$(TARGETS_UF2))

.PHONY: targets.bin
targets.bin: $(addprefix $(DEST_DIR)/,$(TARGETS_BIN))

.PHONY: targets.uf2
targets.uf2: $(addprefix $(DEST_DIR)/,$(TARGETS_UF2))

$(DEBUG_TARGET_DIR)/examples/%: examples/%.rs
	cargo build --example="$*"

$(RELEASE_TARGET_DIR)/examples/%: examples/%.rs
	cargo build --release --example="$*"

$(DEBUG_TARGET_DIR)/%: src/bin/%.rs
	cargo build --bin="$*"

$(RELEASE_TARGET_DIR)/%: src/bin/%.rs
	cargo build --release --bin="$*"

$(DEST_DIR)/example-%.debug.bin: $(DEBUG_TARGET_DIR)/examples/%
	rust-objcopy $(DEBUG_TARGET_DIR)/examples/$* --output-target "binary" $(DEST_DIR)/example-$*.debug.bin

$(DEST_DIR)/example-%.bin: $(RELEASE_TARGET_DIR)/examples/%
	rust-objcopy $(RELEASE_TARGET_DIR)/examples/$* --output-target "binary" $(DEST_DIR)/example-$*.bin

$(DEST_DIR)/%.debug.bin: $(DEBUG_TARGET_DIR)/%
	rust-objcopy $(DEBUG_TARGET_DIR)/$* --output-target "binary" $(DEST_DIR)/$*.debug.bin

$(DEST_DIR)/%.bin: $(RELEASE_TARGET_DIR)/%
	rust-objcopy $(RELEASE_TARGET_DIR)/$* --output-target "binary" $(DEST_DIR)/$*.bin

$(DEST_DIR)/%.uf2: $(DEST_DIR)/%.bin
	uf2conv --convert --family=STM32F4 --base 0x8010000 --output="$(DEST_DIR)/$*.uf2" $(DEST_DIR)/$*.bin
