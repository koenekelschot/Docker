ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy Nessus"
ensure_folder ${VOLUMES}/nessus