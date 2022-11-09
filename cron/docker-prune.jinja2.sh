# runs as root every sunday at 04:00
# shellcheck disable=SC2148

# shellcheck disable=SC1091
. {{ global.docker_volume }}/cron/log.sh

log "Starting Docker system prune"
log "$(/usr/local/bin/docker system prune -a -f 2>&1)"
log "Finished Docker system prune"