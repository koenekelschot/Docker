echo "Deploy websites"
ensure_folder_exists {{ global.docker_volumes }}/websites/{{ websites.domain_koen }}/config
ensure_folder_exists {{ global.docker_volumes }}/websites/{{ websites.domain_koen }}/logs
ensure_folder_exists {{ global.docker_volumes }}/websites/{{ websites.domain_koen }}/public
ensure_folder_exists {{ global.docker_volumes }}/websites/{{ websites.domain_paul }}/config
ensure_folder_exists {{ global.docker_volumes }}/websites/{{ websites.domain_paul }}/logs
ensure_folder_exists {{ global.docker_volumes }}/websites/{{ websites.domain_paul }}/public
copy_file ./projects/websites/config/koen.conf {{ global.docker_volumes }}/websites/{{ websites.domain_koen }}/config/default.conf
copy_file ./projects/websites/config/paul.conf {{ global.docker_volumes }}/websites/{{ websites.domain_paul }}/config/default.conf

{% raw %}
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' website-koen )" == "running" ]; then
    /usr/local/bin/docker restart website-koen
fi
if [ "$( /usr/local/bin/docker container inspect -f '{{.State.Status}}' website-paul )" == "running" ]; then
    /usr/local/bin/docker restart website-paul
fi
{% endraw %}
