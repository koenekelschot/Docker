#!/bin/bash

inputFiles=""
outputFile="docker-compose.yml"

for x in `ls`; do
    if [[ $x =~ docker-compose\.([a-zA-Z0-9]*)\.y(a|)ml ]]; then
        inputFiles+=" $x"
    fi
done
if [[ $inputFiles == "" ]]; then
    echo "No input files found. Exiting."
    exit -1;
fi

echo "Merging:${inputFiles}"
echo `docker run --rm -i -v ${PWD}:/workdir mikefarah/yq yq merge $inputFiles`
echo "Done."