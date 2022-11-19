# shellcheck disable=SC2148

log() {
    local folder={{ global.cron_folder }}/../logs
    local file=$folder/cron.log

    test -d $folder || mkdir -p $folder
    touch $file

    echo "$(date '+%F %T') | $1" >> $file
    echo "$1"
}