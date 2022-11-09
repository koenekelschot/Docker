#!/bin/bash

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

if [ ! -f /etc/sudoers.bak ]; then
    copy_file /etc/sudoers /etc/sudoers.bak
    echo "{{ ssh_user }} ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
fi
