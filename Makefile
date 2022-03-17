DENO_VERSION := 1.6.0
DENO_INSTALL := third_party
include deno.mk

.PHONY: all
all: $(DENO_BIN)
	$(call deno,run https://deno.land/std/examples/welcome.ts)

# end-example

.PHONY: update_readme
update_readme: $(DENO_BIN)
	$(call deno,fmt update_readme.ts)
	$(call deno,run --allow-all update_readme.ts)