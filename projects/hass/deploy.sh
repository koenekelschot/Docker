ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy homeassistant"
ensure_folder ${VOLUMES}/deconz
ensure_folder ${VOLUMES}/esphome
ensure_folder ${VOLUMES}/homeassistant