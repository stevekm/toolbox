#!/bin/bash

# http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_12_02.html
# https://mywiki.wooledge.org/SignalTrap
# https://stackoverflow.com/questions/9256644/identifying-received-signal-name-in-bash

echo "pid is $$"

# trap_with_arg() {
#     func="$1" ; shift
#     for sig ; do
#         trap "$func $sig" "$sig"
#     done
# }
#
# func_trap() {
#     echo Trapped: $1
# }
# trap_with_arg func_trap HUP INT QUIT KILL TERM EXIT USR1 USR2 SIGHUP SIGINT SIGQUIT SIGKILL SIGTERM

# how to catch all the following traps
trap "echo 'caught HUP'" HUP
trap "echo 'caught INT'" INT
trap "echo 'caught QUIT'" QUIT
trap "echo 'caught KILL'" KILL
trap "echo 'caught TERM'" TERM
trap "echo 'caught EXIT'" EXIT
trap "echo 'caught USR1'" USR1
trap "echo 'caught USR2'" USR2
trap "echo 'caught SIGHUP'" SIGHUP
trap "echo 'caught SIGQUIT'" SIGQUIT
trap "echo 'caught SIGKILL'" SIGKILL
trap "echo 'caught SIGTERM'" SIGTERM
trap "echo 'caught SIGINT'" SIGINT

while :
do
sleep 3
printf "."
done
