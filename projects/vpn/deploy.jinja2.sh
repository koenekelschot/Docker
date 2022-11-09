echo "Deploy VPN"
# shellcheck disable=SC1091
. {{ global.docker_volume }}/cron/create-vpn.sh
