#!/bin/bash

empty_folder() {
    test -d "$1" && rm -r -v "$1"
}

/usr/local/bin/docker-compose up -d --build --remove-orphans

empty_folder "projects"
rm "deploy.sh"
rm "post-deploy.sh"
