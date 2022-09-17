ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy gitlab"
ensure_folder ${VOLUMES}/gitlab-runner
cp ./projects/ci-cd/runner/config.template.toml ${VOLUMES}/gitlab-runner/config.template.toml
cp ./projects/ci-cd/runner/gitlab-runner-registrator.sh ${VOLUMES}/gitlab-runner/gitlab-runner-registrator.sh
cp ./projects/ci-cd/gitlab-create-backup.sh ${VOLUMES}/gitlab/gitlab-create-backup.sh
cp ./projects/ci-cd/gitlab-restore-backup.sh ${VOLUMES}/gitlab/gitlab-restore-backup.sh