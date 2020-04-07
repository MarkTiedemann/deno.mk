DENO_VERSION := 0.39.0
DENO_INSTALL := third_party
include deno.mk

.PHONY: all
all: $(DENO_BIN)
	$(call deno,https://deno.land/std/examples/welcome.ts)

.PHONY: clean
clean:
	$(call deno_clean)
