ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy registry"
ensure_folder ${VOLUMES}/registry
