#!/bin/bash

empty_folder() {
    echo "Cleaning folder $SSH_FOLDER_DOCKER/$1"
    sshpass -e ssh -o StrictHostKeyChecking=no $SSH_USER@$SSH_HOST "test -d $SSH_FOLDER_DOCKER/$1 && rm -r -v $SSH_FOLDER_DOCKER/$1"
}

copy_folder() {
    empty_folder $1
    echo "Copying folder $1"
    sshpass -e scp -o StrictHostKeyChecking=no -r $1 $SSH_USER@$SSH_HOST:$SSH_FOLDER_DOCKER/$1
}

copy_file() {
    echo "Copying file $1"
    sshpass -e scp -o StrictHostKeyChecking=no $1 $SSH_USER@$SSH_HOST:$SSH_FOLDER_DOCKER/$1
}

run_deploy() {
    echo "Starting deploy"
    sshpass -e ssh -o StrictHostKeyChecking=no $SSH_USER@$SSH_HOST "cd $SSH_FOLDER_DOCKER; echo \"$SSH_PASS\" | sudo -S ./deploy.sh"
}

export SSHPASS=$SSH_PASS
copy_folder "cron"
copy_folder "projects"
copy_file "deploy.sh"
copy_file "docker-compose.yml"
run_deploy