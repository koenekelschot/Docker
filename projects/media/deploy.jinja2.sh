ensure_folder_exists {{ global.media_folder }}/Movies
ensure_folder_exists {{ global.media_folder }}/Series
ensure_folder_exists {{ global.downloads_folder }}
ensure_folder_exists {{ global.downloads_folder }}/torrents
ensure_folder_exists {{ global.docker_volumes }}/bazarr
ensure_folder_exists {{ global.docker_volumes }}/deluge
ensure_folder_exists {{ global.docker_volumes }}/radarr
ensure_folder_exists {{ global.docker_volumes }}/sonarr
