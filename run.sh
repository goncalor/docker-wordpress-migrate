#!/bin/bash

WP_PORT="8080"

. globals.sh

# it seems "-e lang=C.UTF-8" is needed only during the import of the database

# run mariadb container
docker run --name $DB_CONT_NAME -v $DB_DATA_NAME:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=$DB_PASS -d mariadb

# run wordpress container
docker run --name $WP_CONT_NAME --link $DB_CONT_NAME:mysql -v $WP_DATA_NAME:/var/www/html -e WORDPRESS_DB_NAME=wordpress -d wordpress

# "www-data" must own the files so that for example updates work with no problems
docker exec $WP_CONT_NAME chown -R www-data:www-data /var/www/html
# chown?
# default permissions in the Wordpress image are -rw-r--r-- for files and drwxr-xr-x for directories
# consider https://codex.wordpress.org/Hardening_WordPress
