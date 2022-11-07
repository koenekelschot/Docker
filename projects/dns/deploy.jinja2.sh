echo "Deploy adguard"
ensure_folder_exists {{ global.docker_volumes }}/adguard/data
ensure_folder_exists {{ global.docker_volumes }}/adguard/config
