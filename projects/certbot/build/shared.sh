#!/bin/sh

log() {
    local message=$1
    echo "$(date '+%F %T') | $message" >> /logs/certbot.log
}

stop() {
    local code=$1
    log "Exiting."
    exit $code
}

process_certificates() {
    log "Processing certbot result"
    local certbot_result=$1
    if [ $certbot_result -ne 0 ]; then
        log "Error running certbot. Please see /logs/letsencrypt.log for details"
        stop 2
    fi;

    local cert_dir=/etc/letsencrypt/live/$DOMAIN
    local current_cert=/certs/$DOMAIN/cert.pem
    if [ ! -f $current_cert ] && [ ! -d $cert_dir ]; then
        log "Certificates should have been created, but directory $cert_dir does not exist"
        stop 3
    fi;

    # Only do something if no certificate exists in volume of if obtained is newer
    if [ ! -f $current_cert ] || [ $cert_dir/cert.pem -nt $current_cert ]; then
        log "Processing certificates"
        test -d /certs/$DOMAIN || mkdir -p /certs/$DOMAIN
        cp $cert_dir/* /certs/$DOMAIN
        cp /etc/letsencrypt/renewal/$DOMAIN.conf /certs/$DOMAIN/renewal.conf

        # concat the full chain with the private key (e.g. for haproxy)
        cat /certs/$DOMAIN/fullchain.pem /certs/$DOMAIN/privkey.pem > /certs/$DOMAIN/privkey_fullchain.pem

        log "Certificates obtained for $DOMAIN! Certificates are stored in /certs/$DOMAIN"
        if [ "$POST_HOOK" != "" ]; then
            log "Executing post_hook"
            $POST_HOOK
        fi;
    fi;
}
