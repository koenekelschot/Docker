echo "Deploy adguard"
ensure_folder_exists {{ global.docker_volume }}/adguard/data
ensure_folder_exists {{ global.docker_volume }}/adguard/config
