#!/bin/bash
docker exec -it gitlab gitlab-ctl stop puma
docker exec -it gitlab gitlab-ctl stop sidekiq
docker exec -it gitlab gitlab-backup create
docker exec -it gitlab update-permissions >/dev/null 2>&1
docker restart gitlab >/dev/null 2>&1