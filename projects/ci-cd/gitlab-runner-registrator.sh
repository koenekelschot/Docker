#!/bin/bash
# Get the registration token from:
# http://${SERVER_IPv4}:8083/admin/runners
registration_token=''

docker exec -it gitlab-runner \
  gitlab-runner register \
    --non-interactive \
    --url "http://${SERVER_IPv4}:8083/" \
    --registration-token "$registration_token" \
    --executor "docker" \
    --docker-image "alpine:latest" \
    --description "docker-shared-runner-1" \
    --tag-list "docker" \
    --run-untagged="true" \
    --locked="false" \
    --access-level="not_protected"
