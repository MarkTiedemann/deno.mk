# This Makefile was downloaded from: https://raw.githubusercontent.com/MarkTiedemann/deno.mk/master/deno.mk
# For documentation on how to use it, see: https://github.com/MarkTiedemann/deno.mk

.DEFAULT_GOAL := all

ifndef DENO_VERSION
$(error $$DENO_VERSION must be set)
endif

DENO_INSTALL ?= .
DENO_DIR := $(DENO_INSTALL)/deno-$(DENO_VERSION)
DENO_BIN := $(DENO_DIR)/bin/deno

$(DENO_BIN):
	mkdir -p $(DENO_DIR)/bin
	curl -Lo $(DENO_BIN).gz https://github.com/denoland/deno/releases/download/v$(DENO_VERSION)/deno_osx_x64.gz
	gunzip $(DENO_BIN).gz
	chmod +x $(DENO_BIN)

define deno
	DENO_DIR=$(DENO_DIR) $(DENO_BIN) $(1)
endef

define deno_clean
	rm -rf $(DENO_DIR)
endef
