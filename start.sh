#!/bin/sh
set -e

# allow overriding PORT via env; default is 8080
: "${PORT:=8080}"

# ensure permissions (best-effort)
chown -R www-data:www-data /var/www/html || true

# substitute PORT into nginx config and write final config
envsubst '$PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# start php-fpm in foreground? Use -F or --nodaemonize depending on php-fpm version
# php-fpm -F will run in foreground if supported; otherwise run in background then keep nginx foreground.
php-fpm -F &

# start nginx in foreground (PID 1) so Cloud Run sees the HTTP server
nginx -g 'daemon off;'
