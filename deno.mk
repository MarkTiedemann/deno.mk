# This Makefile was downloaded from: https://raw.githubusercontent.com/MarkTiedemann/deno.mk/master/deno.mk
# For documentation on how to use it, see: https://github.com/MarkTiedemann/deno.mk

.DEFAULT_GOAL := all

ifndef DENO_VERSION
$(error $$DENO_VERSION must be set)
endif

DENO_INSTALL ?= .

ifeq ($(OS),Windows_NT)
# Begin Windows

SHELL := cmd.exe

DENO_DIR := $(DENO_INSTALL)\deno-$(DENO_VERSION)
DENO_BIN := $(DENO_DIR)\bin\deno.exe
DENO_ZIP := $(DENO_DIR)\bin\deno.zip

$(DENO_BIN):
	mkdir $(DENO_DIR)\bin
	powershell -c "Invoke-WebRequest -OutFile $(DENO_ZIP) -Uri https://github.com/denoland/deno/releases/download/v$(DENO_VERSION)/deno_win_x64.zip"
	powershell -c "Expand-Archive -Path $(DENO_ZIP) -DestinationPath $(DENO_DIR)\bin"
	del /q $(DENO_ZIP)

define deno
	cmd /C "set DENO_DIR=$(DENO_DIR)& $(DENO_BIN) $(1)"
endef

define deno_clean
	rmdir /q /s $(DENO_DIR)
endef

# End Windows
else
# Begin MacOS / Linux

DENO_DIR := $(DENO_INSTALL)/deno-$(DENO_VERSION)
DENO_BIN := $(DENO_DIR)/bin/deno
OS := $(if $(findstring Darwin,$(shell uname -s)),osx,linux)

$(DENO_BIN):
	mkdir -p $(DENO_DIR)/bin
	curl -Lo $(DENO_BIN).gz https://github.com/denoland/deno/releases/download/v$(DENO_VERSION)/deno_$(OS)_x64.gz
	gunzip $(DENO_BIN).gz
	chmod +x $(DENO_BIN)

define deno
	DENO_DIR=$(DENO_DIR) $(DENO_BIN) $(1)
endef

define deno_clean
	rm -rf $(DENO_DIR)
endef

# End MacOS / Linux
endif
