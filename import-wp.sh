#!/bin/bash

WP_IMPORT="$1"

. globals.sh

# create named volume for wordpress
# docker volume create --name=$WP_DATA_NAME

# copy existing wordpress installation to named volume
# don't mess with the "/." after "from". it's so that hidden files are copied too.
#   "from/*" does not work
docker run --rm -v $WP_IMPORT:/from -v $WP_DATA_NAME:/to wordpress sh -c 'cp -av /from/. /to'

echo Finished importing wordpress files
