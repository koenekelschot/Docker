echo "Deploy VPN"
# shellcheck disable=SC1091
. {{ global.docker_volumes }}/cron/create-vpn.sh
