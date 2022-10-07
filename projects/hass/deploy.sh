ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy homeassistant"
ensure_folder ${VOLUMES}/deconz
ensure_folder ${VOLUMES}/esphome
ensure_folder ${VOLUMES}/homeassistant/config
ensure_folder ${VOLUMES}/homeassistant/data
ensure_folder ${VOLUMES}/homeassistant/logs
touch ${VOLUMES}/homeassistant/logs/home-assistant.log
touch ${VOLUMES}/homeassistant/logs/home-assistant.log.1
touch ${VOLUMES}/homeassistant/logs/home-assistant.log.fault