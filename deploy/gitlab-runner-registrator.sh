#!/bin/bash
# Get the registration token from:
# http://192.168.178.59:8083/admin/runners

docker exec -it gitlab-runner \
  gitlab-runner register \
    --non-interactive \
    --url "http://${SERVER_IPv4}:8083/" \
    --registration-token "${GITLAB_RUNNER_TOKEN}" \
    --executor "docker" \
    --docker-image "alpine:latest" \
    --description "docker-shared-runner-1" \
    --tag-list "docker" \
    --run-untagged="true" \
    --locked="false" \
    --access-level="not_protected"
