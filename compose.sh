#!/bin/bash

outputfile="docker-compose.yml"
inputfiles=""

# define yq shorthand
yq() {
    docker run --rm -i -v ${PWD}:/workdir mikefarah/yq yq $@
}

for x in `ls`; do
    # create backup of existing docker-compose.yml
    if [[ $x == $outputfile ]]; then
        date=`date +"%Y%m%d-%H%M%S"`
        cp $x "docker-compose.$date.bak.yml"
    fi;
    # get relevant files
    if [[ $x =~ docker-compose\.([a-zA-Z0-9]*)\.y(a|)ml ]]; then
        inputfiles+=" $x"
    fi;
done

# create new docker-compose.yml
yq merge $inputfiles > $outputfile;