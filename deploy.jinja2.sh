#!/bin/bash

#/usr/local/bin/docker-compose up -d --build --remove-orphans

ensure_folder_exists() {
    test -d "$1" || mkdir -p "$1"
}

ensure_file_exists() {
    touch "$1"
}

copy_file() {
    cp "$1" "$2"
}

chmod 755 -R /volume1/homes/{{ ssh_user }}
chmod 700 -R /volume1/homes/{{ ssh_user }}/.ssh
chmod 600 /volume1/homes/{{ ssh_user }}/.ssh/authorized_keys
