echo "Deploy registry"
ensure_folder_exists {{ global.docker_volume }}/registry

# https://www.reddit.com/r/docker/comments/jti89x/private_docker_registry_server_gave_http_response/
if [ ! -f /var/packages/Docker/etc/dockerd.json.bak ]; then
    cp /var/packages/Docker/etc/dockerd.json /var/packages/Docker/etc/dockerd.json.bak
    cp ./projects/registy/dockerd-replacement.json /var/packages/Docker/etc/dockerd.json
    echo "Restarting Docker due to config change. This may crash your deploy."
    /usr/syno/sbin/synoservicecfg --restart pkgctl-Docker
fi
