#!/bin/bash

set -e

drupal_dir=/var/www/html
db_dir=/var/lib/mysql

if [ $( docker ps -a | grep drupal | wc -l ) -gt 0 ]; then
    echo "Creating drupal backup ..."
    for folder in modules profiles sites themes
    do
        docker run --rm --volumes-from drupal -v $(pwd):/backup busybox sh -c "cd ${drupal_dir}/$folder && tar cf /backup/drupal_${folder}_backup.tar ."
    done
    echo "drupal backup created correctly."
else
    echo "drupal container is missing."
fi

if [ $( docker ps -a | grep db | wc -l ) -gt 0 ]; then
    echo "Creating db backup ..."
    docker run --rm --volumes-from db -v $(pwd):/backup busybox sh -c "cd ${db_dir} && tar cf /backup/db_backup.tar ."
    echo "db backup created correctly."
else
    echo "db container is missing."
fi