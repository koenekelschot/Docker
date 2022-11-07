echo "Deploy gitlab"
ensure_folder_exists {{ global.docker_volumes }}/gitlab/backup
ensure_folder_exists {{ global.docker_volumes }}/gitlab/config
ensure_folder_exists {{ global.docker_volumes }}/gitlab-runner
copy_file ./projects/ci-cd/runner/config.template.toml {{ global.docker_volumes }}/gitlab-runner/config.template.toml
copy_file ./projects/ci-cd/runner/gitlab-runner-registrator.sh {{ global.docker_volumes }}/gitlab-runner/gitlab-runner-registrator.sh
copy_file ./projects/ci-cd/gitlab-create-backup.sh {{ global.docker_volumes }}/gitlab/gitlab-create-backup.sh
copy_file ./projects/ci-cd/gitlab-restore-backup.sh {{ global.docker_volumes }}/gitlab/gitlab-restore-backup.sh
