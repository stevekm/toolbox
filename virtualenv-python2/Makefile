# setup a virtual environment in Python 2.7 and install dependecies with pip

# default action
all: setup

# create the environment
venv/bin/activate:
	set -x && \
	unset PYTHONPATH && \
	virtualenv venv --no-site-packages &&\
	ln -s venv/bin/activate

# if that does not work try this
# export PYTHONPATH= && \

# install the dependencies
setup: venv/bin/activate
	source venv/bin/activate && \
	pip install -r requirements.txt

clean:
	rm -rf venv
	unlink activate
