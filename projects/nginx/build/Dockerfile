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

CMD ["nginx", "-g", "daemon off;"]