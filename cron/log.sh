log() {
    local folder=/volume1/docker/cron/logs
    local file=$folder/cron.log

    test -d $folder || mkdir -p $folder
    touch $file

    echo "$(date '+%F %T') | $1" >> $file
    echo $1
}