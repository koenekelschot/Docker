ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy gitlab"
ensure_folder ${VOLUMES}/gitlab-runner
cp ./projects/ci-cd/config/gitlab-runner.toml ${VOLUMES}/gitlab-runner/config.toml