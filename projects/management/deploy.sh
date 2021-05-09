ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy management"
ensure_folder ${VOLUMES}/portainer