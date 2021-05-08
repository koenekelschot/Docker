FROM alpine:3.12

RUN mkdir -p /run/nginx && \
    apk add --no-cache \
        tzdata \
        nginx \
        nginx-mod-devel-kit \
        nginx-mod-http-lua \
        nginx-mod-http-headers-more \
        nginx-mod-http-geoip2 \
        nginx-mod-stream-geoip2

STOPSIGNAL SIGQUIT

HEALTHCHECK --interval=10s --timeout=5s --retries=3 CMD wget --no-verbose --tries=1 --spider http://localhost/healthcheck || exit 1

CMD ["nginx", "-g", "daemon off;"]