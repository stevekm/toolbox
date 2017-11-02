#!/bin/bash

# convenience wrapper for searching code in the repo
# put this script inside your repo and adjust the args to ignore annoying files
# use it like 'find', e.g.:
# search_repo.sh -exec grep -l 'import foo' {} \;

args="$@"
repo_dir="$(dirname "$0")"

set -x
find "${repo_dir}/" -type f ! -path "*logs/*" ! -path "*.git/*" ! -name "*.pyc" $args
