#!/usr/bin/env python

'''
Demo of using custom exceptions to raise errors in a program and perform custom actions
'''

import os
import sys
import logging
LOG_FILENAME = 'logging_example.txt'
logging.basicConfig(filename=LOG_FILENAME, level=logging.DEBUG)

class MissingInputFile(Exception):
    def __init__(self, message, errors):

        # Call the base class constructor with the parameters it needs
        super(MissingInputFile, self).__init__(message)

        # Now for your custom code...
        self.errors = errors

class Task1(object):
    def __init__(self, file):
        self.file = file
        if not os.path.exists(self.file):
            raise MissingInputFile(message = 'Input file for {0} does not exist: {1}'.format(self, self.file), errors = '')
    def __repr__(self):
        return('Task1(file = "{0}")'.format(self.file))


def in_case_of_errors(errors):
    logging.error('There was an error!!')
    logging.error(errors, exc_info=True)
    # logging.exception(e)
    # logging.exception(e.errors)

def no_errors():
    logging.info('There were no errors')



if __name__ == "__main__":

    input_file = sys.argv[1]
    logging.info('input_file is {0}'.format(input_file))

    try:
        x = Task1(file = input_file)
    except MissingInputFile as e:
        in_case_of_errors(errors = e)
        raise

    no_errors()
