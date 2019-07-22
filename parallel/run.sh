#!/bin/bash
# https://www.gnu.org/software/parallel/
# https://www.gnu.org/software/parallel/parallel_tutorial.html
# install `parallel` with: $ brew install parallel

ls *.xml | parallel -j 8 python script.py {} {}.csv
