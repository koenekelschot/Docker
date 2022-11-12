echo "Deploy adguard"
ensure_folder_exists {{ global.docker_volume }}/adguard/data
ensure_folder_exists {{ global.docker_volume }}/adguard/config
copy_file ./projects/dns/config/AdGuardHome.yaml {{ global.docker_volume }}/adguard/config/AdGuardHome.yaml
