#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
An example of using Python's argparse library with subparsers

Usage
-----

$ ./argparse_subparser.py foo zzz
(do_foo) the value is: zzz

$ ./argparse_subparser.py bar 2 3 45
(do_bar) the values are: ['2', '3', '45']
(do_bar) itsTrue: False

$ ./argparse_subparser.py bar 2 3 45 --itsTrue
(do_bar) the values are: ['2', '3', '45']
(do_bar) itsTrue: True

"""
import argparse

def do_foo(**kwargs):
    """
    Perform the foo task
    """
    value = kwargs.pop('value')
    print("(do_foo) the value is: {}".format(value))

def do_bar(**kwargs):
    """
    Perform the bar task
    """
    values = kwargs.pop('values')
    itsTrue = kwargs.pop('itsTrue')
    print("(do_bar) the values are: {}".format(values))
    print("(do_bar) itsTrue: {}".format(itsTrue))

def parse():
    """
    Parse the script CLI arguments
    """
    parser = argparse.ArgumentParser(description = 'Example Python argparse script')
    subparsers = parser.add_subparsers(help ='Sub-commands available')

    # subparser for foo
    foo = subparsers.add_parser('foo', help = 'Run the foo function')
    foo.add_argument('value', help = 'Value to run the foo function on')
    foo.set_defaults(func = do_foo)

    # subparser for bar
    bar = subparsers.add_parser('bar', help = 'Run the bar function')
    bar.add_argument('values', nargs = "*", help = "Values to pass to the bar function")
    bar.add_argument('--itsTrue', action = "store_true", help = 'A true/false flag')
    bar.set_defaults(func = do_bar)

    args = parser.parse_args()
    args.func(**vars(args))

if __name__ == '__main__':
    parse()
