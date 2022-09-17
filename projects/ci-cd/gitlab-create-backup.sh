#!/bin/bash
docker exec -it gitlab gitlab-ctl stop puma
docker exec -it gitlab gitlab-ctl stop sidekiq
docker exec -it gitlab gitlab-backup create
docker exec -it gitlab gitlab-ctl start sidekiq
docker exec -it gitlab gitlab-ctl start puma