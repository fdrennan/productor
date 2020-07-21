#!/bin/sh

export NGINX_HOST_NAME

envsubst '${NGINX_HOST_NAME}' < /nginx.conf > /etc/nginx/conf.d/mysite.template

exec "$@"