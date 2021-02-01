#!/bin/sh

. /shared.sh

log "Cron triggered"
if [ "`echo $IS_TEST | tr '[:upper:]' '[:lower:]'`" = "false" ]; then
    certbot renew -q --noninteractive --logs-dir /logs
    process_certificates $?
else 
    certbot renew -v --noninteractive --test-cert --logs-dir /logs
    process_certificates $?
fi;