ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy gitlab"
ensure_folder {{ global.docker_volumes }}/gitlab/backup
ensure_folder {{ global.docker_volumes }}/gitlab/config
ensure_folder {{ global.docker_volumes }}/gitlab-runner
cp ./projects/ci-cd/runner/config.template.toml {{ global.docker_volumes }}/gitlab-runner/config.template.toml
cp ./projects/ci-cd/runner/gitlab-runner-registrator.sh {{ global.docker_volumes }}/gitlab-runner/gitlab-runner-registrator.sh
cp ./projects/ci-cd/gitlab-create-backup.sh {{ global.docker_volumes }}/gitlab/gitlab-create-backup.sh
cp ./projects/ci-cd/gitlab-restore-backup.sh {{ global.docker_volumes }}/gitlab/gitlab-restore-backup.sh