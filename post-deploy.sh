#!/bin/bash

empty_folder() {
    test -d "$SSH_FOLDER_DOCKER/$1" && rm -r -v "${SSH_FOLDER_DOCKER:?}/$1"
}

/usr/local/bin/docker-compose up -d --build --remove-orphans

empty_folder "projects"
