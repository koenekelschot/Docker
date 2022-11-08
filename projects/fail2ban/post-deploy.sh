echo "Restart fail2ban"
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' fail2ban )" == "running" ]; then
    /usr/local/bin/docker restart fail2ban
fi
