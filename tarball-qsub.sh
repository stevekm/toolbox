#!/bin/bash

# submit a qsub job to SGE scheduler to tarball a directory, 
# then lock the tarball file and delete the original directory

inputDir="${1}"
qsub_logdir="tarball-logs"
job_name="tb-${inputDir}"

mkdir -p "${qsub_logdir}"

qsub -wd $PWD -o :${qsub_logdir}/ -e :${qsub_logdir}/ -j y -N "${job_name}" <<E0F
set -x
tar -cvzf "${inputDir}.tar.gz" "${inputDir}" && \
chmod a-w "${inputDir}.tar.gz" && \
rm -rf "${inputDir}"
E0F
