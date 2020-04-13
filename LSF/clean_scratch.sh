#!/bin/bash

# script for cleaning up the contents of the node scratch dir
# need to use a regular bsub job if you do not have ssh access to the node

machines=$(bhosts | egrep "(^j.[0-9]+)" | grep -v unavail | awk '{print $1}')

for machine in $machines; do
    echo "rm -rf /scratch/$USER; mkdir -p /scratch/$USER" | \
    bsub \
    -n 1 \
    -sla CMOPI \
    -W 00:10 \
    -o $PWD/${machine}.%J.out.log \
    -e $PWD/${machine}.%J.err.log \
    -R "select[hname==$machine]"
done
