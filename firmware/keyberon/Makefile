target/thumbv7em-none-eabihf/debug/%: src/bin/%.rs
	cargo build --bin="$*"

target/thumbv7em-none-eabihf/release/%: src/bin/%.rs
	cargo build --release --bin="$*"

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
