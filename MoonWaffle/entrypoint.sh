#!/bin/bash
sed -i s/REV_BACKEND_IP/$REV_BACKEND_IP/g /opt/openresty/nginx/conf/nginx.conf
sed -i s/REV_BACKEND_PORT/$REV_BACKEND_PORT/g /opt/openresty/nginx/conf/nginx.conf
sed -i s/PGSPEED_ENABLED/$PGSPEED_ENABLED/g /opt/openresty/nginx/conf/nginx.conf

echo "Startup settings: "
echo "Backend IP Address: $REV_BACKEND_IP"
echo "Backend PORT: $REV_BACKEND_PORT"
echo "Pagespeed status: $PGSPEED_ENABLED"

/opt/openresty/nginx/sbin/nginx
