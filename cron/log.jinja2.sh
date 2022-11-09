# shellcheck disable=SC2148

log() {
    local folder={{ global.docker_volume }}/logs
    local file=$folder/cron.log

    test -d $folder || mkdir -p $folder
    touch $file

    echo "$(date '+%F %T') | $1" >> $file
    echo "$1"
}