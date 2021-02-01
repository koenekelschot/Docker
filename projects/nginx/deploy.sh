ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

fix_dsm() {
    cp $1 $1.bak
    sed -i "s/80/8880/g" $1
    sed -i "s/443/8881/g" $1
}

echo "Deploy nginx"
ensure_folder ${VOLUMES}/nginx/logs
ensure_folder ${VOLUMES}/nginx/servers
touch ${VOLUMES}/nginx/logs/default-access.log
touch ${VOLUMES}/nginx/logs/default-error.log
touch ${VOLUMES}/nginx/logs/homeassistant-access.log
touch ${VOLUMES}/nginx/logs/homeassistant-acme-challenge.log
touch ${VOLUMES}/nginx/logs/homeassistant-error.log
touch ${VOLUMES}/nginx/logs/homeassistant-ssl-access.log
touch ${VOLUMES}/nginx/logs/homeassistant-ssl-error.log
cp ./projects/nginx/config/nginx.conf ${VOLUMES}/nginx/nginx.conf
cp ./projects/nginx/config/servers/* ${VOLUMES}/nginx/servers/

# Freeing up port 80 on Synology DSM, rewrites port 80 to 8880 and 443 to 8881
# https://stackoverflow.com/a/55561347
if [ ! -f /usr/syno/share/nginx/server.mustache.bak ]; then
    fix_dsm /usr/syno/share/nginx/server.mustache
    fix_dsm /usr/syno/share/nginx/DSM.mustache
    fix_dsm /usr/syno/share/nginx/WWWService.mustache
    /usr/syno/sbin/synoservicecfg --restart nginx
fi
if [ ! -f ${VOLUMES}/nginx/dhparams.pem ]; then
    /bin/openssl dhparam -dsaparam -out ${VOLUMES}/nginx/dhparams.pem 4096
fi
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' nginx )" == "running" ]; then
    /usr/local/bin/docker restart nginx
fi