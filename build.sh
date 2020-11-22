#!/bin/bash

import_env() {
    echo "Import .env variables"
    # https://stackoverflow.com/a/24957725
    # `s/^ *//`  => left trim
    # `s/ *$//`  => right trim
    # `/^$/d`    => remove empty line
    # `/^\s*$/d` => delete lines which may contain white space
    # `/^#/d`    => remove lines starting with `#`
    # https://stackoverflow.com/a/2613853
    # IN UNIX ENVIRONMENT: convert DOS newlines (CR/LF) to Unix format.
    # sed 's/.$//'               # assumes that all lines end with CR/LF
    # sed 's/^M$//'              # in bash/tcsh, press Ctrl-V then Ctrl-M
    # sed 's/\x0D$//'            # works on ssed, gsed 3.02.80 or higher
    sed 's/\x0D$//; s/^ *//; s/ *$//; /^$/d; /^#/d' /etc/host/docker/.env > env-vars

    echo "Generate variable replacements"
    # https://stackoverflow.com/a/2915592
    sed -e 's/^/s|${/g' -e 's/=/}\|/g' -e 's/$/\|/g' env-vars > replace.sed
}

delete_temp_files() {
    echo "Deleting temporary files"
    rm env-vars
    rm replace.sed
}

replace_variables() {
    echo "Replace variables in $1"
    # https://unix.stackexchange.com/a/474507
    find . -type f -name "$1" -exec sed -i -f replace.sed {} \;

    echo "Checking for unreplaced variables"
    local unreplaced=$(find . -type f -name "$1" -exec grep -l "\${" {} \;)
    if [ "$unreplaced" != "" ]; then
        echo "Unreplaced variables found in:"
        printf '%s' "${unreplaced}"
        echo ""

        return 1
    fi
    
    return 0
}

create_compose() {
    echo "Creating docker-compose.yml"
    test -f docker-compose.yml || touch docker-compose.yml
    cat projects/default.yml > docker-compose.yml
    find projects/ -mindepth 2 -type f -name '*.yml' -exec sed -e 's/^/  /' {} >> docker-compose.yml \;

    return 0
}

import_env

replace_variables "*.conf"
conf=$?

replace_variables "*.toml"
toml=$?

replace_variables "*.yml"
yml=$?

create_compose
compose=$?

delete_temp_files

if  [ $conf != 0 ] || 
    [ $toml != 0 ] || 
    [ $yml != 0 ] || 
    [ $compose != 0 ]; then
    exit 1
fi