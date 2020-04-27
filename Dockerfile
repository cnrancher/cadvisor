FROM    google/cadvisor:v0.33.0

RUN     apk update \
    &&  apk add nginx gettext curl bash

ADD     entrypoint.sh /usr/bin/entrypoint.sh
ADD     nginx.conf.tmpl /etc/nginx/nginx.conf.tmpl

RUN     mkdir -p /run/nginx \
    &&  chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]