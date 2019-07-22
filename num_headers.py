#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Finds the number of unique headers in a list of files
"""
import argparse
from collections import defaultdict

def get_header(filepath):
    """
    Get the header line from a file

    Parameters
    ----------
    filepath: str
        the path to a file to read

    Returns
    -------
    str
        the first line of the file
    """
    header = None
    for i, x in enumerate(open(filepath)):
        if i == 0:
            header = x
    return(header)



def main(**kwargs):
    """
    Main control function for the script.

    Parameters
    ----------
    kwargs: dict
        dictionary containing args to run the program

    Keyword Arguments
    -----------------
    files: list
        a list of file paths
    keep_none: bool
        include files with no lines in the count (default: 'False')
    """
    # get the args that were passed
    files = kwargs.pop('files', [])
    keep_none = kwargs.pop('keep_none', False)
    verbose = kwargs.pop('verbose', False)

    # hold all the headers in a dict with counter
    headers = defaultdict(int)

    # get all the headers
    for f in files:
        headers[get_header(f)] += 1

    # remove a 'None' key, if present (means there were empty files passed)
    if not keep_none:
        headers.pop(None, None)

    num_headers = len(headers.keys())

    if verbose:
        print(num_headers)
    return(num_headers)

def run():
    """
    Runs the program if called as a script

    Examples
    --------
    Example usage::

        find output/ -maxdepth 2 -name "*_summary.tsv" ! -name "*IonXpress_*" | xargs toolbox/num_headers.py
    """
    parser = argparse.ArgumentParser(description='This script will count the number of unique headers (1st line) amongs all files')

    # positional args
    parser.add_argument("files", help="Paths to input files", nargs="+")

    # optional args
    parser.add_argument("--keep-none", default = False, action='store_true', dest = 'keep_none', help="Whether or not to count empty files")
    parser.add_argument("-v", "--verbose", default = True, action='store_false', dest = 'verbose', help="Whether or not to print the number of lines to console")

    args = parser.parse_args()

    main(**vars(args))


if __name__ == "__main__":
    run()
