echo "Deploy portainer"
ensure_folder_exists {{ global.docker_volume }}/portainer
