target/thumbv7em-none-eabihf/debug/examples/%: examples/%.rs
	cargo build --example="$*"

target/thumbv7em-none-eabihf/release/examples/%: examples/%.rs
	cargo build --release --example="$*"

target/thumbv7em-none-eabihf/debug/%: src/bin/%.rs
	cargo build --bin="$*"

target/thumbv7em-none-eabihf/release/%: src/bin/%.rs
	cargo build --release --bin="$*"

example-%.debug.bin: target/thumbv7em-none-eabihf/debug/examples/%
	rust-objcopy \
	  target/thumbv7em-none-eabihf/debug/examples/$* \
	  --output-target "binary" \
	  example-$*.debug.bin

example-%.bin: target/thumbv7em-none-eabihf/release/examples/%
	rust-objcopy \
	  target/thumbv7em-none-eabihf/release/examples/$* \
	  --output-target "binary" \
	  example-$*.bin

%.debug.bin: target/thumbv7em-none-eabihf/debug/%
	rust-objcopy \
	  target/thumbv7em-none-eabihf/debug/$* \
	  --output-target "binary" \
	  $*.debug.bin

%.bin: target/thumbv7em-none-eabihf/release/%
	rust-objcopy \
	  target/thumbv7em-none-eabihf/release/$* \
	  --output-target "binary" \
	  $*.bin

%.uf2: %.bin
	uf2conv --convert \
	  --family=STM32F4 \
	  --base 0x8010000 \
	  --output="$*.uf2" \
	  ./$*.bin
