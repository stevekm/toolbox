# setup a virtual environment in Python 2.7 and install dependecies with pip

# no default action
none:

# create the environment
venv/bin/activate:
	set -x && \
	unset PYTHONPATH && \
	virtualenv venv --no-site-packages &&\
	ln -s venv/bin/activate

# install the dependencies
setup: venv/bin/activate
	source venv/bin/activate && \
	pip install -r requirements.txt

clean:
	unlink activate
	rm -rf venv