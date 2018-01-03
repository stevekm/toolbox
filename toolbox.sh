#!/bin/bash

spinner()
{
    # function for a cursor-spinner while a process is running
    # Example:
    # ( command ) &
    # spinner
    local pid=$!
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}


sleep_counter=0 # counter to track `sleep_count`
sleep_limit=200 # the value for `sleep_count` sleep on

sleep_count () {
    # pause a script after the `sleep_count` function has been invoked a certain number of times
    # NOTE: does not work with loops that include pipes; https://serverfault.com/a/259342/346367
    local sleep_limit="$sleep_limit"

    if [ "$sleep_counter" -eq "$sleep_limit" ] ; then
        printf "\n\nLimit reached. Sleeping....\n\n" 
        sleep 2
        sleep_counter=0
    else
        sleep_counter=$((sleep_counter+1))
    fi
}
