echo "Deploy websites"
ensure_folder_exists {{ global.docker_volume }}/websites/{{ websites.domain_koen }}/config
ensure_folder_exists {{ global.docker_volume }}/websites/{{ websites.domain_koen }}/logs
ensure_folder_exists {{ global.docker_volume }}/websites/{{ websites.domain_koen }}/public
ensure_folder_exists {{ global.docker_volume }}/websites/{{ websites.domain_paul }}/config
ensure_folder_exists {{ global.docker_volume }}/websites/{{ websites.domain_paul }}/logs
ensure_folder_exists {{ global.docker_volume }}/websites/{{ websites.domain_paul }}/public
copy_file ./projects/websites/config/koen.conf {{ global.docker_volume }}/websites/{{ websites.domain_koen }}/config/default.conf
copy_file ./projects/websites/config/paul.conf {{ global.docker_volume }}/websites/{{ websites.domain_paul }}/config/default.conf
