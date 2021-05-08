# runs as root every sunday at 04:00
. /volume1/docker/cron/log.sh

log "Starting Docker system prune"
log "$(/usr/local/bin/docker system prune -a -f 2>&1)"
log "Finished Docker system prune"