#!/bin/sh
set -eu
: "${PORT:=80}"

# Render config to default.conf (NOT nginx.conf)
envsubst '${PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/conf.d/default.conf

# Test and start
nginx -t
exec nginx -g 'daemon off;'