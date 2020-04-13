#!/bin/bash

# make a list of files to use for jobs submission

printf "Sample\tSet\tType\tPath\n" > files_list.txt
for file in $(find -L . -maxdepth 5 -type f -name "*.original.vcf" ! -path '*/fixtures/*' -path '*VCF-GATK-HC*'); do
    # split the path apart to get field IDs
    setID="$(basename $(dirname $(dirname $file)))"
    vcf_type="$(basename $(dirname $file))"
    sampleID="$(basename $file)"
    sampleID="${sampleID%%.original.vcf}"
    path="$(readlink -f $file)"

    # print all the values to a file
    printf "%s\t%s\t%s\t%s\n" "$sampleID" "$setID" "$vcf_type" "$path" >> files_list.txt
done
cat files_list.txt
