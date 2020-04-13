#!/bin/bash

# submit arguments to run as a  qsub job to run on the SGE HPC

args="$@"
qsub_logdir="logs"
mkdir -p "${qsub_logdir}"

job_name="myjob"

qsub -wd $PWD -o :${qsub_logdir}/ -e :${qsub_logdir}/ -j y -N "$job_name" -b y bash -c "set -x; $args"
