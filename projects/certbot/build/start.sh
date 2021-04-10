#!/bin/bash

log() {
    echo "$(date '+%F %T') | $1" >> /logs/certbot.log
}

# Adapted from https://github.com/vdhpieter/docker-letsencrypt-webroot/blob/master/start.sh

if [[ -z $DOMAIN ]]; then
  log "No domains set, please fill -e 'DOMAINS=example.com www.example.com'"
  exit 1
fi

if [[ -z $EMAIL ]]; then
  log "No email set, please fill -e 'EMAIL=your@email.tld'"
  exit 1
fi

if [[ $STAGING -eq 1 ]]; then
  log "Using the staging environment"
  ADDITIONAL="--staging"
fi

exp_limit=28
cert_file="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"

renew() {
    certbot certonly \
        --webroot \
        -w /var/www/certbot \
        --logs-dir /logs \
        --agree-tos \
        --noninteractive \
        --force-renewal \
        --email ${EMAIL} \
        -d ${DOMAIN} \
        ${ADDITIONAL}

    if [[ -e $cert_file ]]; then
        cat $cert_file /etc/letsencrypt/live/$DOMAIN/privkey.pem > /etc/letsencrypt/live/$DOMAIN/privkey_fullchain.pem
    fi;

    if [ "$POST_HOOK" != "" ]; then
        log "Executing post_hook"
        $POST_HOOK
    fi;
    
    log "Renewal process finished for domain $DOMAIN"
}

check() {
    cert_file="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"

    if [[ -e $cert_file ]]; then
        exp=$(date -d "`openssl x509 -in $cert_file -text -noout|grep "Not After"|cut -c 25-`" +%s)
        datenow=$(date -d "now" +%s)
        days_exp=$[ ( $exp - $datenow ) / 86400 ]

        log "Checking expiration date for $DOMAIN..."

        if [ "$days_exp" -gt "$exp_limit" ] ; then
            log "The certificate is up to date, no need for renewal ($days_exp days left)."
        else
            log "The certificate for $DOMAIN is about to expire soon. Starting webroot renewal script..."

            if [[ ! -L $cert_file ]]; then
                rm -Rf /etc/letsencrypt/live/$DOMAIN
            fi;

            renew
        fi
    else 
        log "No certificate found for $DOMAIN. Starting webroot renewal script..."
        renew
    fi

    sleep 12h
    check
}

check
