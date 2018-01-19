#!/bin/bash
# setup a virtual environment in Python 3.6 and install dependecies with pip
# start env with:
# $ . activate
# close env with:
# $ deactivate
python3 -m venv venv
ln -s venv/bin/activate
source venv/bin/activate
pip install -r requirements.txt
