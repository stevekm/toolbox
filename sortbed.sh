#!/bin/bash

# script to sort a .bed file

bed_file="$1"

sort_bed () {
    local bed_file="$1"
    # local tmp_file="$(dirname "$bed_file")/tmp"
    # -V is available in GNU coreutils >8.17
    sort -V -k1,1 -k2,2n "$bed_file" # > "$tmp_file" && /bin/mv "$tmp_file" "$bed_file"
}

sort_bed "$bed_file"
