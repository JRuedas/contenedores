#!/bin/bash

set -e

drupal_dir=/var/www/html
db_dir=/var/lib/mysql

for value in drupal db
do
    if [ $( docker ps -a | grep $value | wc -l ) -gt 0 ]; then
        echo "Creating $value backup ..."
        dir="${value}_dir"
        docker run --rm --volumes-from $value -v $(pwd):/backup busybox tar cf /backup/${value}_backup.tar ${!dir}
        echo "$value backup created correctly."
    else
        echo "$value container is missing."
    fi    
done