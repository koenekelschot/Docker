ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy postgresql"
ensure_folder ${VOLUMES}/postgresql
chown -R 999:999 ${VOLUMES}/postgresql
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' postgresql )" == "running" ]; then
    /usr/local/bin/docker restart postgresql
fi

echo "Deploy pgadmin"
ensure_folder ${VOLUMES}/pgadmin
chown -R 5050:5050 ${VOLUMES}/pgadmin