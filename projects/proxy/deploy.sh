ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy swag"
ensure_folder ${VOLUMES}/swag
cp ./projects/proxy/geoip2.conf ${VOLUMES}/swag/nginx/geoip2.conf
cp ./projects/proxy/nginx.conf ${VOLUMES}/swag/nginx/nginx.conf
cp ./projects/proxy/homeassistant.proxy.conf ${VOLUMES}/swag/nginx/proxy-confs/homeassistant.subdomain.conf