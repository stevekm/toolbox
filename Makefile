SHELL:=/bin/bash

# no default action to take
none:
	echo "This Makefile does not do anything its just a an example template"

# check the operating system
check-mac:
	[ "$$(uname)" != "Darwin" ] && echo "this is only for Macs" && exit 1 || :

# make sure a program is installed
vagrant-installed:
	type vagrant >/dev/null 2>&1 || { echo >&2 "I require vagrant but it's not installed.  Aborting."; exit 1; }


# demo Makefile vs. shell variable expansion
HG19_GENOME_FA_MD5:=c1ddcc5db31b657d167bea6d9ff354f9
ref-data:
	echo "$(HG19_GENOME_FA_MD5) ${HG19_GENOME_FA_MD5} $${HG19_GENOME_FA_MD5:=none}"

# output:
# $ make ref-data
# echo "c1ddcc5db31b657d167bea6d9ff354f9 c1ddcc5db31b657d167bea6d9ff354f9 ${HG19_GENOME_FA_MD5:=none}"
# c1ddcc5db31b657d167bea6d9ff354f9 c1ddcc5db31b657d167bea6d9ff354f9 none
