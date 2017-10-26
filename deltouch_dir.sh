#!/bin/bash

# Delete all files in a directory and replace them with 'touched' versions of the original file

# ~~~~~ SCRIPT ARGS ~~~~~ #
# get args
validation="$1"
input_dir="$2"


# ~~~~~ FUNCTIONS ~~~~~ #
validate_arg () {
    # make sure the provided arg is 'yes'
    local validation="$1"
    if [ "$validation" != 'yes' ]; then
        printf '\nWARNING!! This script will delete your files!!\n'
        printf 'First script argument must be "yes" in order to run this script!!\n\nYou entered: %s\n\nTry again\n' "$validation"
        exit 1
    fi
}

validate_input_dir () {
    # make sure the input directory is valid
    local input_dir="$1"

    # check for zero length string
    if [ -z "$input_dir" ] ; then
        printf 'ERROR: Directory name "%s" is length zero; you didnt enter a directory!\n' "$input_dir"
        exit 1
    fi

    # make sure the dir exists
    if [ ! -d "$input_dir" ] ; then
        printf 'ERROR: Directory "%s" does not exist!\n' "$input_dir"
        exit 1
    fi
}

deltouch () {
    # delete the original file and 'touch' a new empty copy with the same name
    local filename="$1"
    if [ -f "$filename" ]; then
        {
            printf 'Deleting %s ...' "$filename"
            rm -f "$filename"
        } && {
            printf 'success\n'
            touch "$filename"
        } || {
            printf "ERROR: File could not be deleted\n"
        }
    fi
}




# ~~~~~ RUN ~~~~~ #
# check the script args
validate_arg "$validation"
validate_input_dir "$input_dir"

# find and delete the files
find "$input_dir" -type f -print0 | while read -d $'\0' item; do
    deltouch "$item"
done
