ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy folding-at-home"
ensure_folder ${VOLUMES}/folding-at-home