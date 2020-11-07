# runs as root every saturday at 04:00
cd /volume1/docker
docker-compose down
date=`date +"%Y%m%d"`
tar czvf "/volume1/Backups/Docker/${date}.tar.gz" ./
docker-compose up -d