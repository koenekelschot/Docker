#!/bin/bash

outputfile="docker-compose.yml"
inputfiles=""
backupdir="backups"

yq() {
    docker run --rm -i -v ${PWD}:/workdir mikefarah/yq yq $@
}

backup() {
    if [ -f $outputfile ]; then
        date=`date +"%Y%m%d-%H%M%S"`
        mkdir -p $backupdir
        cp $outputfile "${backupdir}/docker-compose.$date.yml"
    fi;
}

for x in `ls`; do
    if [[ $x =~ docker-compose\.([a-zA-Z0-9]*)\.y(a|)ml ]]; then
        inputfiles+=" $x"
    fi;
done

backup
yq merge $inputfiles > $outputfile;