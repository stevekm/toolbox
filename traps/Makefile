SHELL:=/bin/bash

# methods to use traps from within a Makefile

test:
	trap "echo Booh!" SIGINT SIGTERM ; \
	echo "pid is $$$$" ; \
	while : ; \
	do \
	sleep 60 ; \
	echo "...exiting..."; \
	done

run:
	if [ -e ".nextflow.pid" ]; then rm -f .nextflow.pid ; fi
	$(MAKE) run-recurse

run-recurse:
	./nextflow run  main.nf -bg && \
	echo "its done"


# submit a SLURM HPC cluster job that runs Nextflow then tries to trap the 'scancel' signal and gracefully shut down
submit:
	printf "#!/bin/bash\n set -x \n \
	trap 'echo caught SIGTERM; ps -p \$$PID; kill -s 2 -\$$(ps -p \$$PID -o pgid= | tr -d \" \")' SIGTERM \n \
	trap 'echo caught EXIT, exiting...; [[ \$$PID ]] && echo \$$PID is still here' EXIT \n \
	./nextflow run  main.nf & PID=\$$!  \n \
	wait \n \
	" | sbatch -D "$$PWD" -o "%j.out" -J "trap" -p "cpu_short" --ntasks-per-node=1 -c "1" /dev/stdin



# if [ -e ".nextflow.pid" ]; then rm -f .nextflow.pid ; fi
# sbatch -D "$$PWD" -o "%j.out" -J "test_trap" -p "cpu_short" --ntasks-per-node=1 -c "1" --wrap='./set_traps.sh'
# sbatch -D "$$PWD" -o "%j.out" -J "test_trap" -p "cpu_short" --ntasks-per-node=1 -c "1" set_traps.sh
# printf "#!/bin/bash\n ./set_traps.sh" | sbatch -D "$$PWD" -o "%j.out" -J "test_trap" -p "cpu_short" --ntasks-per-node=1 -c "1" /dev/stdin
# printf "#!/bin/bash\n trap 'echo caugh SIGTERM' SIGTERM \n trap 'exiting...' EXIT \n echo pid is $$$$ \n while : ; do sleep 2; printf . ; done" | sbatch -D "$$PWD" -o "%j.out" -J "test_trap" -p "cpu_short" --ntasks-per-node=1 -c "1" /dev/stdin
# wait \$$(head -1 .nextflow.pid) \n \ -bg
# && echo 'nextflow ran'

# this one almost works::
# printf "#!/bin/bash\n set -x \n \
# trap 'echo caught SIGTERM; kill \$$PID' SIGTERM \n \
# trap 'echo caught EXIT, exiting...; kill \$$PID' EXIT \n \
# ./nextflow run  main.nf & PID=\$$!  \n \
# echo \$$PID \n \
# wait \$$PID \n \
# " | sbatch -D "$$PWD" -o "%j.out" -J "trap" -p "cpu_short" --ntasks-per-node=1 -c "1" /dev/stdin

# printf "#!/bin/bash\n set -x \n \
# trap 'echo caught SIGTERM; head -1 .nextflow.pid | xargs kill -s 2' SIGTERM \n \
# trap 'echo caught EXIT, exiting...; head -1 .nextflow.pid' EXIT \n \
# make run \
# " | sbatch -D "$$PWD" -o "%j.out" -J "trap" -p "cpu_short" --ntasks-per-node=1 -c "1" /dev/stdin
