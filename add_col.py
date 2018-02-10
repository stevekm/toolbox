#!/usr/bin/env python

"""
Adds a column of integer numbers
Read from stdin

Usage:
$ find output/ -name "*.hg19_multianno.txt" -exec wc -l {} \; | ./add_col.py
1640206
"""
import sys
import argparse

def main(**kwargs):
    """
    Main control function for the script
    """
    input_file = kwargs.pop('input_file', None)

    if input_file:
        fin = open(input_file)
    else:
        fin = sys.stdin

    nums = []

    for line in fin:
        num = int(line.split().pop(0))
        nums.append(num)
    fin.close()

    print(sum(nums))

def parse():
    """
    parse script args and pass them to `main`
    """
    parser = argparse.ArgumentParser(description='This script will concatenate multiple table files with a common header')
    parser.add_argument("-i", default = False, dest = 'input_file', metavar = 'input file', help="Path to the input file")
    args = parser.parse_args()

    main(**vars(args))

if __name__ == "__main__":
    parse()
