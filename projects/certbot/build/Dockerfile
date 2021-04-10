FROM certbot/certbot

RUN apk --no-cache add docker-cli bash coreutils grep

ADD start.sh /bin/start.sh

ENTRYPOINT [ "/bin/bash", "/bin/start.sh" ]