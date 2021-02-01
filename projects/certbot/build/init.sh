#!/bin/sh

. shared.sh

log "Certbot started"
log "Domain: $DOMAIN"
log "Email: $EMAIL"
log "Post hook: $POST_HOOK"
log "Test: $IS_TEST"

if [ "$DOMAIN" != "" ] && [ "$EMAIL" != "" ]; then 
    if [ -f /certs/$DOMAIN/renewal.conf ]; then
        log "Existing renewal config found, not requesting new certificates"
        cp /certs/$DOMAIN/renewal.conf /etc/letsencrypt/renewal/$DOMAIN.conf
    else
        log "No renewal config found, requesting new certificates"
        if [ "`echo $IS_TEST | tr '[:upper:]' '[:lower:]'`" = "false" ]; then
            certbot certonly --noninteractive --agree-tos -m $EMAIL --logs-dir /logs --webroot -w /webroot -d $DOMAIN
            process_certificates $?
        else 
            certbot certonly --noninteractive --agree-tos -m $EMAIL --test-cert --logs-dir /logs --webroot -w /webroot -d $DOMAIN
            process_certificates $?
        fi;
    fi;

    log "Starting cron"
    # start crond with log level 8 in foreground, output to stderr
    crond -f -d 8
else 
    log "No domain or email provided"
    stop 1
fi;