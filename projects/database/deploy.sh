# run as root 
echo "Deploy postgresql"
chown -R 999:999 /volume1/docker/volumes/postgresql

echo "Deploy pgadmin"
chown -R 5050:5050 /volume1/docker/volumes/pgadmin