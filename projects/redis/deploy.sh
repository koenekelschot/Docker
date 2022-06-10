ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy redis"
ensure_folder ${VOLUMES}/redis/data