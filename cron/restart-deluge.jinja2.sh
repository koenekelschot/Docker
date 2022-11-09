# runs as root every day at 00:00
# shellcheck disable=SC2148

# shellcheck disable=SC1091
. {{ global.docker_volumes }}/cron/log.sh

log "Restarting Deluge"
log "$(/usr/local/bin/docker restart deluge 2>&1)"
log "Restarted Deluge"