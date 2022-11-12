echo "Restart AdGuard"
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' adguard )" == "running" ]; then
    /usr/local/bin/docker restart adguard
fi
