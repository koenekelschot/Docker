echo "Deploy homeassistant"
ensure_folder_exists {{ global.docker_volumes }}/deconz
ensure_folder_exists {{ global.docker_volumes }}/esphome
ensure_folder_exists {{ global.docker_volumes }}/homeassistant/config
ensure_folder_exists {{ global.docker_volumes }}/homeassistant/data
ensure_folder_exists {{ global.docker_volumes }}/homeassistant/logs
ensure_file_exists {{ global.docker_volumes }}/homeassistant/logs/home-assistant.log
ensure_file_exists {{ global.docker_volumes }}/homeassistant/logs/home-assistant.log.1
ensure_file_exists {{ global.docker_volumes }}/homeassistant/logs/home-assistant.log.fault
