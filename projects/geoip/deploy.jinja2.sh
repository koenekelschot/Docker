ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy geoip"
ensure_folder {{ global.docker_volumes }}/geoip