#!/bin/bash
#BSUB -oo lsf.log
#BSUB -W 100
#BSUB -J foo_job
#BSUB -M 1
#BSUB -n 2,3

# Example LSF submit script
# submit with: bsub < bsub_example.sh
# otherwise embedded BSUB params will not take effect

# example bsub command without script:
# bsub \
# -sla cmo \
# -oo lsf.log \
# -W 100 \
# <commands>

# Resources:
# https://www.ibm.com/support/knowledgecenter/SSETD4_9.1.2/lsf_command_ref/bsub.1.html
# https://www.ibm.com/support/knowledgecenter/SSWRJV_10.1.0/lsf_config_ref/lsf_envars_ref.html
# https://tin6150.github.io/psg/3rdParty/lsf4_userGuide/12-customizing.html

date +'%s'

LSF_vars='LSB_BATCH_JID LSB_JOBID LSB_JOBFILENAME LSB_JOBNAME LSB_SUB_RES_REQ LSB_QUEUE LS_SUBCWD LSB_HOSTS LSB_DJOB_NUMPROC LSB_SUB_HOST LSB_OUTPUTFILE LSB_OUTDIR LSFUSER LS_JOBPID LSB_JOB_EXECUSER LSF_JOB_TIMESTAMP_VALUE LSB_BIND_CPU_LIST LSB_BIND_MEM_LIST LSB_JOBGROUP LSB_JOBINDEX LSB_JOBINDEX_STEP LSB_MAX_NUM_PROCESSORS'

for item in ${LSF_vars}; do printf "${item}: ${!item:-none}\n"; done;

echo "---------"
env
echo "---------"
