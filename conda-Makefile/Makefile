SHELL:=/bin/bash
# get system information; Mac (Darwin) or Linux
UNAME:=$(shell uname)


# ~~~~~ Setup Conda ~~~~~ #
# this sets the system PATH to ensure we are using in included 'conda' installation for all software
PATH:=$(CURDIR)/conda/bin:$(PATH)
unexport PYTHONPATH
unexport PYTHONHOME

# install versions of conda for Mac or Linux
ifeq ($(UNAME), Darwin)
CONDASH:=Miniconda3-4.5.4-MacOSX-x86_64.sh
endif

ifeq ($(UNAME), Linux)
CONDASH:=Miniconda3-4.5.4-Linux-x86_64.sh
endif

CONDAURL:=https://repo.continuum.io/miniconda/$(CONDASH)

# install conda in the current directory
# in a directory called 'conda'
# - note: use '&&' to make sure each command succeeded before continuing..
# - note: need to use '\' line breaks because otherwise GNU make executes each line in a separate environment
# - note: Makefile variables pre-populate shell commands before they are executed
conda:
	@echo ">>> Setting up conda..."
	@wget "$(CONDAURL)" && \
	bash "$(CONDASH)" -b -p conda && \
	rm -f "$(CONDASH)"

# Example of a complex Python software installation
# - need ncurses installed from conda-forge for rabbitmq to work
# - need Python 3.7; Miniconda3 4.5.4 ships with 3.6
# - need extra packages that are only available from pip
# - - pip here will install to the 'conda' directory, not the system or user directories
# - - also note that this pip ships with conda, not the same pip as on global system
# - note: this version of rabbitmq has issues with macOS El Capitan
# ~~~ put your commands and criteria here ~~~ #
install: conda
	conda install -y conda-forge::ncurses && \
	conda install -y -c anaconda -c bioconda \
	python=3.7 \
	django=2.1.5 \
	nextflow=19.01.0 \
	rabbitmq-server=3.7.13 && \
	pip install \
	celery==4.3.0 \
	django-celery-results==1.0.4 \
	django-celery-beat==1.4.0 \
	flower==0.9.3

test1:
	which conda
	which pip
	which python
	python --version
	python -c 'import django; print(django.__version__)'

# enter interactive shell sessions with environment configured
python:
	python

bash:
	bash

CMD:=
cmd:
	$(CMD)
