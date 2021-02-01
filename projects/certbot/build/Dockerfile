FROM alpine:3.12

COPY cronjobs /etc/crontabs/root
COPY *.sh /

RUN apk --no-cache add docker-cli certbot openssl && \
    mkdir -p /webroot /certs /logs && \
    touch /logs/certbot.log && \
    chmod +x *.sh

ENV DOMAIN=""
ENV EMAIL=""
ENV POST_HOOK=""
ENV IS_TEST="true"

VOLUME /webroot
VOLUME /certs
VOLUME /logs
VOLUME /var/run/docker.sock

ENTRYPOINT [ "./init.sh" ]