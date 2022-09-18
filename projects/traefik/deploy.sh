ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

fix_dsm() {
    cp $1 $1.bak
    sed -i "s/80/8880/g" $1
    sed -i "s/443/8881/g" $1
}

echo "Deploy traefik"
ensure_folder ${VOLUMES}/traefik/config
ensure_folder ${VOLUMES}/traefik/logs
ensure_folder ${VOLUMES}/traefik/waf/logs/nginx
touch ${VOLUMES}/traefik/waf/logs/nginx/access.log
touch ${VOLUMES}/traefik/waf/logs/nginx/error.log
cp ./projects/traefik/config/traefik.yml ${VOLUMES}/traefik/config/traefik.yml
cp ./projects/traefik/config/config.yml ${VOLUMES}/traefik/config/config.yml
cp ./projects/traefik/waf/logging.conf.template ${VOLUMES}/traefik/waf/logging.conf.template
cp ./projects/traefik/waf/before.conf ${VOLUMES}/traefik/waf/before.conf
cp ./projects/traefik/waf/after.conf ${VOLUMES}/traefik/waf/after.conf

# Freeing up port 80 on Synology DSM, rewrites port 80 to 8880 and 443 to 8881
# https://stackoverflow.com/a/55561347
if [ ! -f /usr/syno/share/nginx/server.mustache.bak ]; then
    fix_dsm /usr/syno/share/nginx/server.mustache
    fix_dsm /usr/syno/share/nginx/DSM.mustache
    fix_dsm /usr/syno/share/nginx/WWWService.mustache
    /usr/syno/sbin/synoservicecfg --restart nginx
fi

# Reload config
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' traefik )" == "running" ]; then
    /usr/local/bin/docker restart traefik
fi