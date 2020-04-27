#!/bin/bash

export CADVISOR_PORT=${CADVISOR_PORT}

for port in {30000..31000};
do
    if ! netstat -tulpn | grep ${port} >> /dev/null; then
        export PORT=${port}
        break
    fi
done

envsubst < /etc/nginx/nginx.conf.tmpl > /etc/nginx/nginx.conf

nginx

/usr/bin/cadvisor -logtostderr -listen_ip=127.0.0.1 --port=${PORT} $*
