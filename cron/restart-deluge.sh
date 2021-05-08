# runs as root every day at 00:00
. /volume1/docker/cron/log.sh

log "Restarting Deluge"
log "$(/usr/local/bin/docker restart deluge 2>&1)"
log "Restarted Deluge"