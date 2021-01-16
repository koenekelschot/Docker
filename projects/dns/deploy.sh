ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy adguard"
ensure_folder ${VOLUMES}/adguard/data
ensure_folder ${VOLUMES}/adguard/config