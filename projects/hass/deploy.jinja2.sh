echo "Deploy homeassistant"
ensure_folder_exists {{ global.docker_volume }}/deconz
ensure_folder_exists {{ global.docker_volume }}/esphome
ensure_folder_exists {{ global.docker_volume }}/homeassistant/config
ensure_folder_exists {{ global.docker_volume }}/homeassistant/data
ensure_folder_exists {{ global.docker_volume }}/homeassistant/logs
ensure_file_exists {{ global.docker_volume }}/homeassistant/logs/home-assistant.log
ensure_file_exists {{ global.docker_volume }}/homeassistant/logs/home-assistant.log.1
ensure_file_exists {{ global.docker_volume }}/homeassistant/logs/home-assistant.log.fault
