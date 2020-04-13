Example template scripts to use for submitting a large batch of jobs to the HPC cluster (SGE)

Typical use case:

- `make_file_list.sh`: build a list of files to process, parse out metadata, save to .tsv file

- `submit.sh`: iterate over the lines in the file list and generate a `qsub` job for each item to submit to the cluster
