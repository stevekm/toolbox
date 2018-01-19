# setup a virtual environment in Python 3.6 and install dependecies with pip

# no default action
none:

# setup the virtual environment
venv/bin/activate:
	set -x && \
	unset PYTHONPATH && \
	python3 -m venv venv &&\
	ln -s venv/bin/activate

# install the dependencies
setup: venv/bin/activate
	source venv/bin/activate && \
	pip install -r requirements.txt

clean:
	rm -rf venv
	unlink activate
