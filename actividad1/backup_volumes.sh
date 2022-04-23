#!/bin/bash

set -e

if [ $( docker ps -a | grep drupal | wc -l ) -gt 0 ]; then
    echo "Creating drupal backup ..."
    docker run --rm --volumes-from drupal -v $(pwd):/backup busybox tar cf /backup/drupal_backup.tar /var/www/html
    echo "Drupal backup created correctly."
else
    echo "Drupal container is missing"
fi

if [ $( docker ps -a | grep db | wc -l ) -gt 0 ]; then
    echo "Creating db backup ..."
    docker run --rm --volumes-from db -v $(pwd):/backup busybox tar cf /backup/db_backup.tar /var/lib/mysql
    echo "DB backup created correctly."
else
    echo "DB container is missing"
fi