# Install Python Anaconda (or Miniconda) and create an environment
SHELL:=/bin/bash
ANACONDA_MD5:=c989ecc8b648ab8a64731aaee9ed2e7e
ANACONDA_sh:=Anaconda3-5.0.1-Linux-x86_64.sh
# path to installation location
INSTALL_DIR:=${CURDIR}
# YAML file to use for setting up Conda environment
ENV_YAML:=xmltodict.yml
ENV_NAME:=xmltodict


# no default action to take
none:


# ~~~~~ INSTALLATION ~~~~~ #
${ANACONDA_sh}:
	wget https://repo.continuum.io/archive/$(ANACONDA_sh)

# download the script
download: $(ANACONDA_sh)

# check md5sum
verify: download
	AnacondaMD5="$$(./get_md5sum.sh $(ANACONDA_sh))" && \
	if [ "$$AnacondaMD5" == '$(ANACONDA_MD5)' ]; then echo "md5sum matches"; else echo "md5sum does not matches"; exit 1; fi

# install Anaconda
install: verify
	bash $(ANACONDA_sh) -b -p $(INSTALL_DIR)/anaconda


# ~~~~~ SETUP ~~~~~ #
# create the Conda environment
setup:
	. activate_anaconda.sh && \
	conda env create -f $(ENV_YAML)

# make sure it all works
test:
	. activate_anaconda.sh && \
	source activate $(ENV_NAME) && \
	which python && \
python -c 'import $(ENV_NAME); print($(ENV_NAME).__file__)'


# ~~~~~ CLEAN UP ~~~~~ #
# remove the Conda environment from the Conda installation
remove:
	. activate_anaconda.sh && \
	conda remove --name $(ENV_NAME) --all -y

# remove files to start over
clean: remove
	rm -f $(ANACONDA_sh)*
	rm -rf anaconda
