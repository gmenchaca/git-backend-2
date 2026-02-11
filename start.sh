#!/bin/sh
set -eu
: "${PORT:=80}"

# Render config and start ONLY nginx
envsubst '${PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
nginx -t
exec nginx -g 'daemon off;'