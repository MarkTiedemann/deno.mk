# This Makefile was downloaded from: https://raw.githubusercontent.com/MarkTiedemann/deno.mk/master/deno.mk
# For documentation on how to use it, see: https://github.com/MarkTiedemann/deno.mk

.DEFAULT_GOAL := all

ifndef DENO_VERSION
$(error $$DENO_VERSION must be set)
endif

DENO_INSTALL ?= .

ifeq ($(OS),Windows_NT)
# begin-windows

SHELL := cmd.exe

DENO_DIR := $(DENO_INSTALL)\deno-$(DENO_VERSION)
DENO_ZIP := $(DENO_DIR)\bin\deno.zip
DENO_BIN := $(DENO_DIR)\bin\deno.exe

$(DENO_BIN):
	md $(DENO_DIR)\bin
	curl -Lo $(DENO_ZIP) https://github.com/denoland/deno/releases/download/v$(DENO_VERSION)/deno-x86_64-pc-windows-msvc.zip
	powershell Expand-Archive $(DENO_ZIP) -Destination $(DENO_DIR)\bin
	del /q $(DENO_ZIP)

define deno
	cmd /c "set DENO_DIR=$(DENO_DIR)& $(DENO_BIN) $(1)"
endef

# end-windows
else
# begin-macos-linux

DENO_DIR := $(DENO_INSTALL)/deno-$(DENO_VERSION)
DENO_BIN := $(DENO_DIR)/bin/deno

$(DENO_BIN):
	mkdir -p $(DENO_DIR)/bin
	curl -Lo $(DENO_BIN).zip https://github.com/denoland/deno/releases/download/v$(DENO_VERSION)/deno-x86_64-$(if $(findstring Darwin,$(shell uname -s)),apple-darwin,unknown-linux-gnu).zip
	unzip -d $(DENO_DIR)/bin $(DENO_BIN).zip
	rm $(DENO_BIN).zip
	chmod +x $(DENO_BIN)

define deno
	DENO_DIR=$(DENO_DIR) $(DENO_BIN) $(1)
endef

# end-macos-linux
endif
