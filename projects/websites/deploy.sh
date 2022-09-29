ensure_folder() {
    test -d "$1" || mkdir -p "$1"
}

echo "Deploy websites"
ensure_folder ${VOLUMES}/websites/${DOMAIN_KOEN}/config
ensure_folder ${VOLUMES}/websites/${DOMAIN_KOEN}/logs
ensure_folder ${VOLUMES}/websites/${DOMAIN_KOEN}/public
ensure_folder ${VOLUMES}/websites/${DOMAIN_PAUL}/config
ensure_folder ${VOLUMES}/websites/${DOMAIN_PAUL}/logs
ensure_folder ${VOLUMES}/websites/${DOMAIN_PAUL}/public
cp ./projects/websites/config/koen.conf ${VOLUMES}/websites/${DOMAIN_KOEN}/config/default.conf
cp ./projects/websites/config/paul.conf ${VOLUMES}/websites/${DOMAIN_PAUL}/config/default.conf

if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' website-koen )" == "running" ]; then
    /usr/local/bin/docker restart website-koen
fi
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' website-paul )" == "running" ]; then
    /usr/local/bin/docker restart website-paul
fi