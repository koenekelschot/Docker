# runs as root every day at 03:00
. /volume1/docker/cron/log.sh

#/volume1/docker/volumes/gitlab/gitlab-create-backup.sh
log "Starting backup Gitlab"
log "$(/volume1/docker/volumes/gitlab/gitlab-create-backup.sh)"
log "Finished backup Gitlab"
