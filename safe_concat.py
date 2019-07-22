#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Concatenates table files but checks to make sure they have the same number of headers first

Usage example:
find -L . -maxdepth 3 -type f -name "VCF-GATK-HC-annot.all.txt" | xargs ./toolbox/safe_concat.py > VCF-GATK-HC-annot.all.concat.txt
"""
import argparse
import num_headers
import concat_tables

def main(file_list, output_file):
    """
    Main control function for the script
    """
    # check the number of headers to make sure theres only 1
    num = num_headers.main(files = file_list)
    if num != 1:
        print("ERROR: There is more than 1 header between the files")
        raise
    else:
        concat_tables.main(file_list = file_list, output_file = output_file)



def parse():
    """
    Parse script arguments
    """
    parser = argparse.ArgumentParser(description='This script will concatenate multiple table files with a common header')
    parser.add_argument("file_list", help="Paths to input table files", nargs="+")
    parser.add_argument("-o", default = False, type = str, dest = 'output_file', metavar = 'Table output file', help="Path to the output table file")
    args = parser.parse_args()
    file_list = args.file_list
    output_file = args.output_file
    main(file_list, output_file)

if __name__ == "__main__":
    parse()
