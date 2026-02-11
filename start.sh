#!/bin/sh
set -eu
set -x

# 1. Use Port 80 for AWS standard (matches your docker-compose environment)
: "${PORT:=80}"

# 2. Render nginx config (only PORT)
envsubst '${PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

echo "=== Rendered /etc/nginx/nginx.conf ==="
cat /etc/nginx/nginx.conf
echo "======================================"

# 3. Test nginx config
nginx -t

# 4. Start nginx in foreground (No PHP here!)
echo "Starting nginx..."
exec nginx -g 'daemon off;'