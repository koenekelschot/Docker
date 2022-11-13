echo "Restart websites"
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' website-koen )" == "running" ]; then
    /usr/local/bin/docker restart website-koen
fi
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' website-paul )" == "running" ]; then
    /usr/local/bin/docker restart website-paul
fi
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' php-fpm )" == "running" ]; then
    /usr/local/bin/docker restart php-fpm
fi
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' php-status )" == "running" ]; then
    /usr/local/bin/docker restart php-status
fi
