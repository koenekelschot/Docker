echo "Deploy fail2ban"
ensure_folder_exists {{ global.docker_volumes }}/fail2ban
ensure_folder_exists {{ global.docker_volumes }}/fail2ban/action.d
ensure_folder_exists {{ global.docker_volumes }}/fail2ban/filter.d
ensure_folder_exists {{ global.docker_volumes }}/fail2ban/jail.d
copy_file ./projects/fail2ban/config/action.d/iptables-common.local {{ global.docker_volumes }}/fail2ban/action.d/iptables-common.local
copy_file ./projects/fail2ban/config/filter.d/hass-login.local {{ global.docker_volumes }}/fail2ban/filter.d/hass-login.local
copy_file ./projects/fail2ban/config/filter.d/traefik-block.local {{ global.docker_volumes }}/fail2ban/filter.d/traefik-block.local
copy_file ./projects/fail2ban/config/filter.d/waf-block.local {{ global.docker_volumes }}/fail2ban/filter.d/waf-block.local
copy_file ./projects/fail2ban/config/jail.d/jail.local {{ global.docker_volumes }}/fail2ban/jail.d/jail.local
