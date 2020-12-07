ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy fail2ban"
ensure_folder ${VOLUMES}/fail2ban
ensure_folder ${VOLUMES}/fail2ban/action.d
ensure_folder ${VOLUMES}/fail2ban/filter.d
ensure_folder ${VOLUMES}/fail2ban/jail.d
cp ./projects/fail2ban/action.d/iptables-common.local.conf ${VOLUMES}/fail2ban/action.d/iptables-common.local
cp ./projects/fail2ban/filter.d/homeassistant.local.conf ${VOLUMES}/fail2ban/filter.d/homeassistant.local
cp ./projects/fail2ban/filter.d/nginx-badbots.local.conf ${VOLUMES}/fail2ban/filter.d/nginx-badbots.local
cp ./projects/fail2ban/filter.d/nginx-deny.local.conf ${VOLUMES}/fail2ban/filter.d/nginx-deny.local
cp ./projects/fail2ban/jail.d/jail.local.conf ${VOLUMES}/fail2ban/jail.d/jail.local
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' fail2ban )" == "running" ]; then
    /usr/local/bin/docker restart fail2ban
fi