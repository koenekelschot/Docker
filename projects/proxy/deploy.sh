ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

fix_dsm() {
    cp $1 $1.bak
    sed -i "s/80/8880/g" $1
    sed -i "s/443/8881/g" $1
}

echo "Deploy swag"
ensure_folder ${VOLUMES}/swag/nginx/proxy-confs
ensure_folder ${VOLUMES}/swag/fail2ban/filter.d
ensure_folder ${VOLUMES}/swag/fail2ban/action.d
cp ./projects/proxy/nginx/geoip2.conf ${VOLUMES}/swag/nginx/geoip2.conf
cp ./projects/proxy/nginx/nginx.conf ${VOLUMES}/swag/nginx/nginx.conf
cp ./projects/proxy/nginx/homeassistant.proxy.conf ${VOLUMES}/swag/nginx/proxy-confs/homeassistant.subdomain.conf
cp ./projects/proxy/fail2ban/jail.conf ${VOLUMES}/swag/fail2ban/jail.local
cp ./projects/proxy/fail2ban/iptables-common-override.conf ${VOLUMES}/swag/fail2ban/action.d/iptables-common.local
cp ./projects/proxy/fail2ban/homeassistant.filter.conf ${VOLUMES}/swag/fail2ban/filter.d/homeassistant.local
# Freeing up port 80 on Synology DSM, rewrites port 80 to 8880 and 443 to 8881
# https://stackoverflow.com/a/55561347
if [ ! -f /usr/syno/share/nginx/server.mustache.bak ]; then
    fix_dsm /usr/syno/share/nginx/server.mustache
    fix_dsm /usr/syno/share/nginx/DSM.mustache
    fix_dsm /usr/syno/share/nginx/WWWService.mustache
    /usr/syno/sbin/synoservicecfg --restart nginx
fi
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' swag )" == "running" ]; then
    /usr/local/bin/docker restart swag
fi