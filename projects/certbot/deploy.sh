ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy certbot"
ensure_folder ${VOLUMES}/certbot/webroot
ensure_folder ${VOLUMES}/certbot/certs
ensure_folder ${VOLUMES}/certbot/logs
