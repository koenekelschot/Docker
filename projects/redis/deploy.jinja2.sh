echo "Deploy redis"
ensure_folder_exists {{ global.docker_volume }}/redis/data
