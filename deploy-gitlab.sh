#!/bin/bash

empty_folder() {
    echo "Cleaning folder $SSH_FOLDER/$1"
    sshpass -e ssh -o StrictHostKeyChecking=no $SSH_USER "test -d $SSH_FOLDER/$1 && rm -r -v $SSH_FOLDER/$1"
}

copy_folder() {
    empty_folder $1
    echo "Copying folder $1"
    sshpass -e scp -o StrictHostKeyChecking=no -r $1 $SSH_USER:$SSH_FOLDER/$1
}

copy_file() {
    echo "Copying file $1"
    sshpass -e scp -o StrictHostKeyChecking=no $1 $SSH_USER:$SSH_FOLDER/$1
}

run_deploy() {
    echo "Starting deploy"
    sshpass -e ssh -o StrictHostKeyChecking=no $SSH_USER "cd $SSH_FOLDER; echo \"$SSH_PASS\" | sudo -S ./deploy.sh"
}

export SSHPASS=$SSH_PASS
copy_folder "cron"
copy_folder "projects"
copy_file "deploy.sh"
copy_file "docker-compose.yml"
run_deploy