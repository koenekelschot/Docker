#!/bin/bash

initialContent=""
inputFiles=""
tempFile="docker-compose.yml.tmp"
outputFile="docker-compose.yml"
backupDir="backups"

if [ -f $outputFile ]; then
    initialContent=`cat ${outputFile}`
fi

inputFiles=""
for x in `ls`; do
    if [[ $x =~ docker-compose\.([a-zA-Z0-9]*)\.y(a|)ml ]]; then
        inputFiles+=" $x"
    fi
done
if [[ $inputFiles == "" ]]; then
    echo "No input files found. Exiting."
    exit
fi

echo "Merging:${inputFiles}"
docker run --rm -i -v ${PWD}:/workdir mikefarah/yq yq merge $inputFiles > "${tempFile}"
mergeContent=`cat ${tempFile}`

if [[ $mergeContent == $initialContent ]]; then
    rm $tempFile
    echo "No changes detected. Exiting."
    exit
fi

if [[ $initialContent != "" ]]; then
    echo "Creating backup of existing ${outputFile}."
    date=`date +"%Y%m%d-%H%M%S"`
    mkdir -p $backupDir
    cp $outputFile "${backupDir}/docker-compose.${date}.yml"
fi

echo "Updating ${outputFile}."
cp $tempFile $outputFile;
rm $tempFile
echo "Done."