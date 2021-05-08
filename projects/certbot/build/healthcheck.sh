#!/bin/bash

log() {
    echo "$(date '+%F %T') | $1" >> /logs/certbot.log
}

cert_file="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"

if [[ ! -e $cert_file ]]; then
    log "No certificate found for $DOMAIN."
    exit 1
fi

CN=$(openssl x509 -noout -subject -in $cert_file | sed -n 's/^subject=CN = //p')
if [ $CN != $DOMAIN ]
then
  log "Certificate CN $CN does not match $DOMAIN."
  exit 1
fi

if openssl x509 -checkend 432000 -noout -in $cert_file
then
  exit 0
else
  log "Certificate has expired or will do so within 5 days!"
  exit 1
fi
