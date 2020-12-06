ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy bazarr"
ensure_folder ${VOLUMES}/bazarr
ensure_folder ${MEDIA}/Movies
ensure_folder ${MEDIA}/Series

echo "Deploy deluge"
ensure_folder ${DOWNLOADS}
ensure_folder ${VOLUMES}/deluge

echo "Deploy jackett"
ensure_folder ${DOWNLOADS}/torrents
ensure_folder ${VOLUMES}

echo "Deploy radarr"
ensure_folder ${VOLUMES}/radarr
ensure_folder ${MEDIA}/Movies
ensure_folder ${DOWNLOADS}

echo "Deploy sonarr"
ensure_folder ${VOLUMES}/sonarr
ensure_folder ${MEDIA}/Series
ensure_folder ${DOWNLOADS}