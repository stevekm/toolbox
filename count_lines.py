#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Counts the number of lines in all files passed
"""
import argparse


def num_lines(filepath, verbose = False, headers = False):
    """
    Counts the number of lines in a file

    Parameters
    ----------
    filepath: str
        the path to the file to count lines

    Returns
    -------
    int
        the number of lines in the file
    """
    num_lines = sum(1 for line in open(filepath))

    # subtract 1 if headers are assumed
    if headers:
        num_lines = max(0, num_lines - 1)

    if verbose:
        print('{0}\t{1}'.format(num_lines, filepath))

    return(num_lines)

def main(**kwargs):
    """
    Main control function for the program

    Parameters
    ----------
    kwargs: dict
        dictionary containing args to run the program

    Keyword Arguments
    -----------------
    files: list
        a list of file paths
    headers: bool
        ``True`` or ``False``, whether or not the files in ``files`` list have header
    """
    # get the args that were passed
    files = kwargs.pop('files', [])
    headers = kwargs.pop('headers', False)
    verbose = kwargs.pop('verbose', False)

    # get line counts
    all_line_nums = [num_lines(f, verbose = verbose, headers = headers) for f in files]

    if verbose:
        print('------------')

    print(sum(all_line_nums))

def run():
    """
    Runs the program if called as a script

    Examples
    --------
    Example usage::

        find output/ -maxdepth 2 -name "*_summary.tsv" ! -name "*IonXpress_*" | xargs toolbox/count_lines.py

    """
    parser = argparse.ArgumentParser(description='This script will count the number of lines in all files')

    # positional args
    parser.add_argument("files", help="Paths to input table files", nargs="+")

    # optional args
    parser.add_argument("--headers", default = False, action='store_true', dest = 'headers', help="Path to the output table file")
    parser.add_argument("-v", "--verbose", default = False, action='store_true', dest = 'verbose', help="print the number of lines per file")

    args = parser.parse_args()

    main(**vars(args))


if __name__ == "__main__":
    run()
