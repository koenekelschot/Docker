ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy pihole"
ensure_folder ${VOLUMES}/pihole/pihole
ensure_folder ${VOLUMES}/pihole/dnsmasq.d