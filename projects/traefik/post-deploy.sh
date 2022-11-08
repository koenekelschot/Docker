echo "Reload traefik"
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' traefik )" == "running" ]; then
    /usr/local/bin/docker restart traefik
fi
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' waf )" == "running" ]; then
    /usr/local/bin/docker restart waf
fi
