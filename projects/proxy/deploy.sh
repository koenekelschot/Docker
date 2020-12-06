ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy swag"
ensure_folder ${VOLUMES}/swag