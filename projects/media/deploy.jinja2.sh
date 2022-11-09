ensure_folder_exists {{ global.media_folder }}/Movies
ensure_folder_exists {{ global.media_folder }}/Series
ensure_folder_exists {{ global.downloads_folder }}
ensure_folder_exists {{ global.downloads_folder }}/torrents
ensure_folder_exists {{ global.docker_volume }}/bazarr
ensure_folder_exists {{ global.docker_volume }}/deluge
ensure_folder_exists {{ global.docker_volume }}/radarr
ensure_folder_exists {{ global.docker_volume }}/sonarr
