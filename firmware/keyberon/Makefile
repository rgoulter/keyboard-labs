TARGET_DIR := target/thumbv7em-none-eabihf
DEBUG_TARGET_DIR ?= $(TARGET_DIR)/debug
RELEASE_TARGET_DIR ?= $(TARGET_DIR)/release
DEST_DIR ?= .

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
