GO    := go
PROMU := $(GOPATH)/bin/promu

PREFIX  ?= $(shell pwd)
BIN_DIR ?= $(shell pwd)

all: build

build:
	@echo ">> building binaries"
	@$(PROMU) build --prefix $(PREFIX)

tarball: promu
	@echo ">> building release tarball"
	@$(PROMU) tarball --prefix $(PREFIX) $(BIN_DIR)

promu:
	@GOOS=$(shell uname -s | tr A-Z a-z) \
		GOARCH=$(subst x86_64,amd64,$(patsubst i%86,386,$(shell uname -m))) \
		$(GO) get -u github.com/prometheus/promu

.PHONY: all build promu tarball
