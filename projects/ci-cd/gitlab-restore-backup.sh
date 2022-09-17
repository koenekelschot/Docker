#!/bin/bash
echo "Please enter the backup to restore (omit '_gitlab_backup.tar'):"
read backup
docker exec -it gitlab gitlab-ctl stop puma
docker exec -it gitlab gitlab-ctl stop sidekiq
docker exec -it gitlab gitlab-backup restore BACKUP=$backup
docker restart gitlab