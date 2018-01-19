#!/bin/bash
# setup a virtual environment in Python 2.7 and install dependecies with pip
# start env with:
# $ . activate
# close env with:
# $ deactivate

set -x
unset PYTHONPATH

virtualenv venv --no-site-packages
ln -s venv/bin/activate
. activate

pip install -r requirements.txt
