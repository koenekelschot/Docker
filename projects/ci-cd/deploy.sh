ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy redis"
ensure_folder ${VOLUMES}/redis
chown -R 999:999 ${VOLUMES}/redis

echo "Deploy gitlab"
ensure_folder ${VOLUMES}/gitlab-runner