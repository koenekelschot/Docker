FROM certbot/certbot

RUN apk --no-cache add docker-cli bash coreutils grep

COPY *.sh /bin/

HEALTHCHECK --interval=10s --timeout=5s --retries=3 CMD /bin/healthcheck.sh

ENTRYPOINT [ "/bin/bash", "/bin/start.sh" ]