# runs as root every day at 03:00
# shellcheck disable=SC2148

# shellcheck disable=SC1091
. {{ global.cron_folder }}/log.sh

restart_gitlab() {
    log "Restarting"
    /usr/local/bin/docker exec gitlab update-permissions >/dev/null 2>&1
    /usr/local/bin/docker restart gitlab >/dev/null 2>&1
}

create_backup() {
    log "Creating backup"
    log "$(/usr/local/bin/docker exec gitlab gitlab-backup create 2>&1)"
}

log "Starting backup Gitlab"
/usr/local/bin/docker exec gitlab gitlab-ctl stop puma
/usr/local/bin/docker exec gitlab gitlab-ctl stop sidekiq
output=$(create_backup)
if [[ $output == *"Rails Error"* ]]; then
    log "Gitlab (permission) error, restarting first"
    restart_gitlab
    log "Waiting until container is started"
    {% raw %}
    until [ "$(/usr/local/bin/docker inspect -f '{{.State.Running}}' gitlab)" == "true" ]; do
    {% endraw %}
        sleep 0.1;
    done;
    create_backup
fi;
restart_gitlab
log "Finished backup Gitlab"
