#!/bin/bash
# setup a virtual environment in Python 2.7 and install AWS CLI

set -x
unset PYTHONPATH

virtualenv venv --no-site-packages
. venv/bin/activate

pip install awscli --upgrade 
