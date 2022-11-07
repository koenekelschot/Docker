ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy adguard"
ensure_folder {{ global.docker_volumes }}/adguard/data
ensure_folder {{ global.docker_volumes }}/adguard/config