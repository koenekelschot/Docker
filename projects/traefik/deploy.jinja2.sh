fix_dsm() {
    copy_file "$1" "$1.bak"
    sed -i "s/80/8880/g" "$1"
    sed -i "s/443/8881/g" "$1"
}

echo "Deploy traefik"
ensure_folder_exists {{ global.docker_volume }}/traefik/config
ensure_folder_exists {{ global.docker_volume }}/traefik/logs
ensure_folder_exists {{ global.docker_volume }}/traefik/waf/logs/nginx
ensure_file_exists {{ global.docker_volume }}/traefik/waf/logs/nginx/access.log
ensure_file_exists {{ global.docker_volume }}/traefik/waf/logs/nginx/error.log
copy_file ./projects/traefik/config/traefik.yml {{ global.docker_volume }}/traefik/config/traefik.yml
copy_file ./projects/traefik/config/config.yml {{ global.docker_volume }}/traefik/config/config.yml
copy_file ./projects/traefik/waf/logging.conf.template {{ global.docker_volume }}/traefik/waf/logging.conf.template
copy_file ./projects/traefik/waf/before.conf {{ global.docker_volume }}/traefik/waf/before.conf
copy_file ./projects/traefik/waf/after.conf {{ global.docker_volume }}/traefik/waf/after.conf

# Freeing up port 80 on Synology DSM, rewrites port 80 to 8880 and 443 to 8881
# https://stackoverflow.com/a/55561347
if [ ! -f /usr/syno/share/nginx/server.mustache.bak ]; then
    fix_dsm /usr/syno/share/nginx/server.mustache
    fix_dsm /usr/syno/share/nginx/DSM.mustache
    fix_dsm /usr/syno/share/nginx/WWWService.mustache
    /usr/syno/sbin/synoservicecfg --restart nginx
fi
