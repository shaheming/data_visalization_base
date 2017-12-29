#!/bin/bash


cd /
cp /docker-compose-file/my_nginx.nginx my_app.conf
/bin/sed -i  "s/server_port/${APP_SERVER}:${APP_LOCAL_PORT}/g" ./my_app.conf
/bin/sed -i  "s/my_server_name/${MY_SERVER_NAME}/g" ./my_app.conf
#if in macOs should add '' after -i
cp my_app.conf /etc/nginx/conf.d/my_app.conf

cp /docker-compose-file/nginx.nginx /etc/nginx/nginx.conf
nginx -g "daemon off;"

#export APP_SERVER=web
#export APP_LOCAL_PORT=3000
#export MY_SERVER_NAME="192.168.31.176"
