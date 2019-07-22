# Makefile template for managing a Python project with Conda
SHELL:=/bin/bash
UNAME:=$(shell uname)

# Python 3 by default
PY:=3
ifeq ($(PY),3)
PATH:=$(CURDIR)/conda/bin:$(PATH)
endif
ifeq ($(PY),2)
PATH:=$(CURDIR)/conda2/bin:$(PATH)
endif

unexport PYTHONPATH
unexport PYTHONHOME

setup: conda-install
.PHONY: setup

# ~~~~~ Setup Conda ~~~~~ #
# install versions of conda for Mac or Linux, Python 2 or 3
# Python 3.6.5 |Anaconda, Inc.| (default, Apr 29 2018, 16:14:56)
# [GCC 7.2.0]
# 2.7.15 |Anaconda, Inc.| (default, May  1 2018, 18:37:05)
# [GCC 4.2.1 Compatible Clang 4.0.1 (tags/RELEASE_401/final)]
ifeq ($(UNAME), Darwin)
CONDASH:=Miniconda3-4.5.4-MacOSX-x86_64.sh
CONDA2SH:=Miniconda2-4.5.4-MacOSX-x86_64.sh
endif

ifeq ($(UNAME), Linux)
CONDASH:=Miniconda3-4.5.4-Linux-x86_64.sh
CONDA2SH:=Miniconda2-4.5.4-Linux-x86_64.sh
endif

CONDAURL:=https://repo.continuum.io/miniconda/$(CONDASH)
CONDA2URL:=https://repo.continuum.io/miniconda/$(CONDA2SH)
conda:
	@echo ">>> Setting up conda..."
	@wget "$(CONDAURL)" && \
	bash "$(CONDASH)" -b -p conda && \
	rm -f "$(CONDASH)"

conda2:
	@echo ">>> Setting up conda..."
	@wget "$(CONDA2URL)" && \
	bash "$(CONDA2SH)" -b -p conda2 && \
	rm -f "$(CONDA2SH)"

# example search for a conda package
conda-search: conda
	conda search '*Django*'

# example install a conda package
conda-install: conda
	conda install -y django=2.1.2

test-conda:
	which conda
	which python
	python -c 'import sys; print(sys.version);'

CMD:=
# run a command in the environment set up with conda
run:
	$(CMD)

# same as above but with Python
py:
	python $(CMD)
