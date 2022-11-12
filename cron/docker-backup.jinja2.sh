# runs as root every saturday at 04:00
# shellcheck disable=SC2148

# shellcheck disable=SC1091
. {{ global.cron_folder }}/log.sh

log "Starting backup"
cd {{ global.docker_volume }} || exit
docker-compose down
date=$(date +"%Y%m%d")
tar czvf "/volume1/Backups/Docker/${date}.tar.gz" ./
docker-compose up -d
log "Finished backup"