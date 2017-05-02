#!/usr/bin/env python

'''
Handy functions that I use a lot
mostly for Python 2.7, with 2.6 and 3.0+ compatibility when possible
'''

def my_debugger(vars):
    '''
    starts interactive Python terminal at location in script
    very handy for debugging
    call this function with
    my_debugger(globals().copy())
    anywhere in the body of the script, or
    my_debugger(locals().copy())
    within a script function
    '''
    import readline # optional, will allow Up/Down/History in the console
    import code
    # vars = globals().copy() # in python "global" variables are actually module-level
    vars.update(locals())
    shell = code.InteractiveConsole(vars)
    shell.interact()

def subprocess_cmd(command):
    '''
    run a terminal command with stdout piping enabled
    '''
    import subprocess as sp
    process = sp.Popen(command,stdout=sp.PIPE, shell=True)
    proc_stdout = process.communicate()[0].strip()
    print proc_stdout

def timestamp():
    '''
    Return a timestamp string
    '''
    import datetime
    return('{:%Y-%m-%d-%H-%M-%S}'.format(datetime.datetime.now()))

def mkdirs(path, return_path=False):
    '''
    Make a directory, and all parent dir's in the path
    '''
    import sys
    import os
    import errno
    try:
        os.makedirs(path)
    except OSError as exc:  # Python >2.5
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise
    if return_path:
        return path

def write_dicts_to_csv(dict_list, output_file):
    '''
    write a list of dicts to a CSV file
    '''
    import csv
    with open(output_file, 'w') as outfile:
        fp = csv.DictWriter(outfile, dict_list[0].keys())
        fp.writeheader() # Python >2.7
        fp.writerows(dict_list)

def backup_file(input_file):
    '''
    backup a file by moving it to a folder called 'old' and appending a timestamp
    '''
    import os
    if os.path.isfile(input_file):
        filename, extension = os.path.splitext(input_file)
        new_filename = '{0}.{1}{2}'.format(filename, timestamp(), extension)
        new_filename = os.path.join(os.path.dirname(new_filename), "old", os.path.basename(new_filename))
        mkdirs(os.path.dirname(new_filename))
        print('Backing up file:\n{0}\n\nTo location:\n{1}\n\n'.format(input_file, new_filename))
        os.rename(input_file, new_filename)

def write_json(object, output_file):
    '''
    Write JSON to a file
    '''
    import json
    with open(output_file,"w") as f:
        json.dump(object, f, indent=4)

def load_json(input_file):
    '''
    Load JSON from a file
    '''
    import json
    with open(input_file,"r") as f:
        my_item = json.load(f)
    return my_item

def list_file_lines(file_path):
    '''
    return the list of entries in a file, one per line
    not blank lines, no trailing \n
    '''
    with open(file_path, 'r') as f:
        entries = [line.strip() for line in f if line.strip()]
    return entries

def concat_file_lines(file, delim = ' '):
    '''
    Join all lines in file together into a single delimited string
    '''
    file_lines = [line.strip() for line in open(file)]
    file_string = delim.join(file_lines)
    return(file_string)

def py_unzip(zip_file, outdir = "."):
    '''
    Extract a ZIP archive from within Pyhton
    '''
    zip_ref = zipfile.ZipFile(zip_file, 'r')
    zip_ref.extractall(outdir)
    zip_ref.close()


def download_file(my_URL, my_outfile = ''):
    '''
    Download a file from a URL, from within Python
    NOTE: Will overwrite output file
    https://gist.github.com/hughdbrown/c145b8385a2afa6570e2
    '''
    import urllib2
    import urlparse
    import os
    URL_basename = os.path.basename(urlparse.urlsplit(my_URL).path)
    # if no output file specified, save to URL filename in current dir
    if my_outfile == '':
        my_outfile = URL_basename
    my_URL = urllib2.urlopen(my_URL)
    with open(my_outfile, 'wb') as output:
        while True:
            data = my_URL.read(4096) # download in chunks
            if data:
                output.write(data)
            else:
                break

def initialize_file(string, output_file):
    '''
    write string to file
    NOTE: This will overwite the file contents
    '''
    with open(output_file, "w") as myfile:
        myfile.write(string + '\n')

def append_string(string, output_file):
    '''
    append string to file
    '''
    with open(output_file, "a") as myfile:
        myfile.write(string + '\n')

def kill_on_false(mybool, my_message = False):
    '''
    Exit the script if a value of 'False' is passed
    '''
    import sys
    message = "ERROR: Something returned 'False' when it shouldn't have. Exiting..."
    if mybool == False:
        if my_message != False: message = my_message
        print message
        sys.exit()

def file_exists(myfile, kill = False):
    '''
    Checks to make sure a file exists, optionally kills the script
    '''
    import os
    import sys
    if not os.path.isfile(myfile):
        print("ERROR: File '{}' does not exist!".format(myfile))
        if kill == True:
            print("Exiting...")
            sys.exit()

def print_div(message = ''):
    '''
    Print a message with a divider
    '''
    divider = '------------------'
    print('{0}\n{1}'.format(divider, message))

def print_dict_source(dict_name, dict_obj):
    '''
    Print a dictionary to the console in copy/pasteable code format
    '''
    print('{0} = {1}'.format(dict_name, json.dumps(dict_obj, sort_keys=True, indent=0)))

def print_str_source(str_name, str_obj, quote = True):
    '''
    Print a string to the console in copy/pasteable code format
    '''
    if quote == False:
        print('{0} = {1}'.format(str_name, str_obj))
    elif quote == True:
        print('{0} = "{1}"'.format(str_name, str_obj))

if __name__ == "__main__":
    print("This script does nothing, it only holds functions")
