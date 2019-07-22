SHELL:=/bin/bash

FILES:=$(shell find . -type f -name "*.xml")
.PHONY: $(FILES)

all: $(FILES)
$(FILES):
	python "$@" "$@.csv"
