ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

copy_config() {
    cp ./projects/fail2ban/config/$1.conf ${VOLUMES}/fail2ban/$1
}

echo "Deploy fail2ban"
ensure_folder ${VOLUMES}/fail2ban
ensure_folder ${VOLUMES}/fail2ban/action.d
ensure_folder ${VOLUMES}/fail2ban/filter.d
ensure_folder ${VOLUMES}/fail2ban/jail.d
copy_config action.d/iptables-common.local
copy_config filter.d/nginx-authfail.local
copy_config filter.d/nginx-badbots.local
copy_config filter.d/nginx-deny.local
copy_config filter.d/nginx-geoblock.local
copy_config filter.d/nginx-notme.local
copy_config filter.d/nginx-untagged.local
copy_config filter.d/traefik-block.local
copy_config filter.d/waf-block.local
copy_config jail.d/jail.local
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' fail2ban )" == "running" ]; then
    /usr/local/bin/docker restart fail2ban
fi