#!/bin/bash

# Check a .zip file for contents whose filenames contain invalid characters (':')
# if found, then unzip, rename the affected files, then re-zip

inputDir="${1:-$PWD}"


fix_zip () {
    local inputZip="${1}"
    local outputDir="${inputZip%%.zip}"
    local outputZip="${outputDir}.fixed.zip"
    
    # extract
    unzip "${inputZip}" -d "${outputDir}"
    
    # rename bad files
    for i in $(find "${outputDir}" -type f -name "*:*"); do
        local newFilename="$(echo "$i" | tr ':' '-')"
        mv "$i" "${newFilename}"
    done
    
    # re-zip
    (
    cd "${outputDir}"
    zip -r "../${outputZip}" *
    )
}



echo "$inputDir"
for item in $(find . -type f -name "*.zip"); do
    echo "$item"

    # check zipfile for bad filenames
    if $(zipinfo -1 "$item" | grep -q ':'); then
        echo ">>> contains bad filenames"
        fix_zip "$item"
    else
        :
    fi
done
