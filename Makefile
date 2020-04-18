DENO_VERSION := 0.41.0
DENO_INSTALL := third_party
include deno.mk

.PHONY: all
all: $(DENO_BIN)
	$(call deno,https://deno.land/std/examples/welcome.ts)

# end-example

.PHONY: update_readme
update_readme: $(DENO_BIN)
	$(call deno,--allow-all update_readme.ts)