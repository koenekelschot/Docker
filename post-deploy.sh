empty_folder() {
    # todo fixen voor lokale aanroep
    echo "Cleaning folder $SSH_FOLDER_DOCKER/$1"
    sshpass -e ssh -o StrictHostKeyChecking=no $SSH_USER@$SSH_HOST "test -d $SSH_FOLDER_DOCKER/$1 && rm -r -v $SSH_FOLDER_DOCKER/$1"
}

/usr/local/bin/docker-compose up -d --build --remove-orphans

empty_folder "projects"

# alle post-deploys samenvoegen?
# of 
# container restarts in gitlab-ci opnemen?
