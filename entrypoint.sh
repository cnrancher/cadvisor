#!/bin/sh

CADVISOR_PORT=${CADVISOR_PORT:-9999}
CADVISOR_ARG=${CADVISOR_ARG}

CMDOPTS="$*"
for OPTS in $CMDOPTS;
do
    key=$(echo ${OPTS} | awk -F"=" '{print $1}' )
    value=$(echo ${OPTS} | awk -F"=" '{print $2}' )
    case "$key" in
        --port) PORT=$value ;;
    esac
done

export PORT=${PORT}
envsubst < /etc/nginx/nginx.conf.tmpl  > /etc/nginx/nginx.conf

nginx

/usr/bin/cadvisor -logtostderr -listen_ip=127.0.0.1 --port=${CADVISOR_PORT} ${CADVISOR_ARG}