#!/bin/bash

# run the commands as jobs on the HPC cluster


# ~~~~~ SETUP ~~~~~ #
# dir for qsub logs
qsub_logdir="logs"
mkdir -p "$qsub_logdir"

output_dir="output"
mkdir -p "output"

# file with sample IDs, paths to files, etc
files_list="files_list.txt"

ANNOVAR_DIR="/ifs/data/molecpathlab/bin/annovar"
ANNOVAR_DB_DIR="/ifs/data/molecpathlab/bin/annovar/db/hg19"
annovar_protocol="refGene,1000g2015aug_all,clinvar_20170905,intervar_20170202,dbnsfp33a,esp6500siv2_all,kaviar_20150923,gnomad_exome,gnomad_genome,avsnp150,fathmm,eigen"
annovar_operation="g,f,f,f,f,f,f,f,f,f,f,f"
build_version="hg19"


# ~~~~~ FUNCTIONS ~~~~~ #
submit_cmd () {
    local sampleID="$1"
    local setID="$2"
    local vcf_type="$3"
    local vcf_file="$4"
    local sample_outdir="$5"

    local job_name="job_$sampleID"
    mkdir -p "$sample_outdir"
    local avinput_file="${sample_outdir}/${sampleID}.avinput"

    cmd="
${ANNOVAR_DIR}/convert2annovar.pl --format vcf4old --includeinfo $vcf_file --outfile $avinput_file

${ANNOVAR_DIR}/table_annovar.pl "$avinput_file" "$ANNOVAR_DB_DIR" --buildver "$build_version" --remove --protocol $annovar_protocol --operation $annovar_operation --nastring .

"
    echo "$cmd"


    qsub -wd $PWD -o :${qsub_logdir}/ -e :${qsub_logdir}/ -j y -N "$job_name" <<E0F
    set -x
    echo "\$(date)"
    $cmd
    echo "\$(date)"
E0F

}



# ~~~~~ RUN ~~~~~ #
tail -n+2 "$files_list" | while read line; do
    if [ ! -z "$line" ]; then
        sampleID="$(echo "$line" | cut -f1)"
        setID="$(echo "$line" | cut -f2)"
        vcf_type="$(echo "$line" | cut -f3)"
        vcf_file="$(echo "$line" | cut -f4)"
        sample_outdir="${output_dir}/${setID}"

        echo "$sampleID $setID $vcf_type $vcf_file"
        submit_cmd $sampleID $setID $vcf_type $vcf_file $sample_outdir
    fi
done
