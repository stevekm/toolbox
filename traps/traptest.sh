#!/bin/bash
# example of catching a signal with a trap

trap "echo Booh!" SIGINT SIGTERM
echo "pid is $$"

while :			# This is the same as "while true".
do
        sleep 5	# This script is not really doing anything.
done
