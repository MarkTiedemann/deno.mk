# This Makefile was downloaded from: https://raw.githubusercontent.com/MarkTiedemann/deno.mk/master/deno.mk
# For documentation on how to use it, see: https://github.com/MarkTiedemann/deno.mk

.DEFAULT_GOAL := all

ifndef DENO_VERSION
$(error $$DENO_VERSION must be set)
endif

DENO_INSTALL ?= .

ifeq ($(OS),Windows_NT)
TARGET := x86_64-pc-windows-msvc
else
UNAME_SM := $(shell uname -sm)
UNAME_S := $(firstword $(UNAME_SM))
ifeq ($(UNAME_SM),Darwin x86_64)
TARGET := x86_64-apple-darwin
else ifeq ($(UNAME_SM),Darwin arm64)
TARGET := aarch64-apple-darwin
else ifeq ($(UNAME_SM),Linux x86_64)
TARGET := x86_64-unknown-linux-gnu
else
$(error $(UNAME_SM) is not supported)
endif
endif

RELEASE_URL := https://github.com/denoland/deno/releases/download/v$(DENO_VERSION)/deno-$(TARGET).zip

ifeq ($(OS),Windows_NT)
# begin-windows

SHELL := cmd.exe

DENO_DIR := $(DENO_INSTALL)\deno-$(DENO_VERSION)
DENO_BIN := $(DENO_DIR)\bin\deno.exe
DENO_ZIP := $(DENO_DIR)\bin\deno.zip

$(DENO_BIN):
	md $(DENO_DIR)\bin
	curl -Lo $(DENO_ZIP) $(RELEASE_URL)
	tar xf $(DENO_ZIP) -C $(DENO_DIR)\bin
	del /q $(DENO_ZIP)

define deno
	set DENO_DIR=$(DENO_DIR)& $(DENO_BIN) $(1)
endef

# end-windows
else
# begin-macos-linux

DENO_DIR := $(DENO_INSTALL)/deno-$(DENO_VERSION)
DENO_BIN := $(DENO_DIR)/bin/deno
DENO_ZIP := $(DENO_BIN).zip

ifeq ($(UNAME_S),Darwin)
DOWNLOAD := curl -Lo $(DENO_ZIP) $(RELEASE_URL)
UNZIP := tar xf $(DENO_ZIP) -C $(DENO_DIR)/bin
else
DOWNLOAD := $(shell \
if command -v curl >/dev/null; then echo "curl -Lo $(DENO_ZIP) $(RELEASE_URL)"; else \
if command -v wget >/dev/null; then echo "wget -O $(DENO_ZIP) $(RELEASE_URL)"; else \
exit 1; fi; fi)
ifneq ($(.SHELLSTATUS),0)
$(error Cannot find program to download deno)
endif
UNZIP := $(shell \
if command -v unzip >/dev/null; then echo "unzip $(DENO_ZIP) -d $(DENO_DIR)/bin"; else \
if command -v bsdtar >/dev/null; then echo "bsdtar xf $(DENO_ZIP) -C $(DENO_DIR)/bin"; else \
if command -v tar >/dev/null && tar --version | grep bsdtar >/dev/null; then echo "tar xf $(DENO_ZIP) -C $(DENO_DIR)/bin"; else \
exit 1; fi; fi; fi)
ifneq ($(.SHELLSTATUS),0)
$(error Cannot find program to unzip deno)
endif
endif

$(DENO_BIN):
	mkdir -p $(DENO_DIR)/bin
	$(DOWNLOAD)
	$(UNZIP)
	chmod +x $(DENO_BIN)
	rm $(DENO_ZIP)

define deno
	DENO_DIR=$(DENO_DIR) $(DENO_BIN) $(1)
endef

# end-macos-linux
endif
