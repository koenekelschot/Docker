echo "Deploy redis"
ensure_folder_exists {{ global.docker_volumes }}/redis/data
