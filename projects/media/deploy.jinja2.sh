ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

ensure_folder {{ global.media_folder }}/Movies
ensure_folder {{ global.media_folder }}/Series
ensure_folder {{ global.downloads_folder }}
ensure_folder {{ global.downloads_folder }}/torrents
ensure_folder {{ global.docker_volumes }}/bazarr
ensure_folder {{ global.docker_volumes }}/deluge
ensure_folder {{ global.docker_volumes }}/radarr
ensure_folder {{ global.docker_volumes }}/sonarr