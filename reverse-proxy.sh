#!/bin/bash

. globals.sh

docker run -v ./reverse-proxy/nginx.conf:/etc/nginx/nginx.conf:ro -p 80:80 --link $WP_CONT_NAME nginx
