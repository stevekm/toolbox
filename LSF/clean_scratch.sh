#!/bin/bash

# script for cleaning up the contents of the node scratch dir
# requires ssh access to nodes;

# To ssh into juno or a node, you need ssh keys available. From your Mac, try:
#
# head -2 ~/.ssh/id_rsa
# ssh-add -K ~/.ssh/id_rsa
# ssh-add -L
# ssh -vA silo
#
# Then from silo, try:
# ssh-add -L
# ssh ja06

if [ "$USER" == "roslin" ]; then echo "dont run this as user roslin"; exit 1; fi
if [ "$USER" == "voyager" ]; then echo "dont run this as user voyager"; exit 1; fi

machines=$(bhosts | egrep "(^j.[0-9]+)" | grep -v unavail | awk '{print $1}')

for machine in $machines; do
    command="echo $machine; rm -rf /scratch/$USER; mkdir -p /scratch/$USER"
    ssh $machine $command
done
