#!/bin/bash

DB_IMPORT="$1"

. globals.sh

# create named volume for mariabd
# docker volume create --name=$DB_DATA_NAME

# build a modified mariadb image which does not leave mysqld running
docker build -t mariadb-import mariadb-import/

# run mariadb container to import .sql or .sql.gz file
docker run --rm -v $DB_DATA_NAME:/var/lib/mysql -v$DB_IMPORT:/docker-entrypoint-initdb.d/db.sql -e MYSQL_ROOT_PASSWORD=$DB_PASS -e LANG=C.UTF-8 -i mariadb-import

echo Finished importing database

# remove the modified mariadb image
docker rmi mariadb-import .

# for testing on localhost "siteurl" and "home" must be changed on the "wp_options" table to "http://localhost:port"
# echo 'use wordpress; update wp_options set option_value="http://localhost:$WP_PORT" where option_id between 1 and 2;' | docker exec -i $DB_CONT_NAME  mysql -u root -p$DB_PASS
