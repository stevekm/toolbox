#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Import a .tsv file to SQLite
"""
import csv
import argparse
import sqlite3
from util import sqlite_tools as sqt # https://github.com/NYU-Molecular-Pathology/util/tree/b40810d7f580fb1884c26af893accc8a9790eb50

key_col = "hash"

def main(**kwargs):
    """
    Main control function for the script
    """
    # get args
    input_tsv = kwargs.pop('input_tsv')
    db_path = kwargs.pop('db_path')

    input_delim = kwargs.pop('input_delim', '\t')
    table_name = kwargs.pop('table_name', 'annotations')


    conn = sqlite3.connect(db_path)
    sqt.create_table(conn = conn, table_name = table_name, col_name = key_col, col_type = "TEXT", is_primary_key = True)
    sqt.import_csv(conn = conn, table_name = table_name, input_file = input_tsv, delimiter = input_delim, add_hash = True)

def parse():
    """
    Parses script arguments
    """
    parser = argparse.ArgumentParser(description='')

    parser.add_argument("-i", dest = 'input_tsv', help="Input .tsv file to load into database", required = True)
    parser.add_argument("-db", dest = 'db_path', help="File to use for the samples.analysis.tsv sheet to be updated", required = True)

    parser.add_argument("--delim", default = '\t', dest = 'input_delim', help="Delimiter for input file")
    parser.add_argument("--table-name", default = 'annotations', dest = 'table_name', help="Delimiter for input file")

    args = parser.parse_args()

    main(**vars(args))


if __name__ == '__main__':
    parse()
