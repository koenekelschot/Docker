#!/bin/bash
# Retrieves the registration token from http://gitlab.${SERVER_NAME}/admin/runners
# and registers the runner based on the template

if [ -f "config.toml" ] ; then
  rm "config.toml"
fi

# https://stackoverflow.com/a/73556697
token=$(docker exec -it gitlab \
  gitlab-rails runner -e production \
    "puts Gitlab::CurrentSettings.current_application_settings.runners_registration_token")

docker exec -it gitlab-runner \
  gitlab-runner register \
    --template-config /etc/gitlab-runner/config.template.toml \
    --non-interactive \
    --registration-token "$token"