#!/bin/bash

set -e

drupal_dir=/var/www/html
db_dir=/var/lib/mysql

echo "Creating containers if missing ..."
docker-compose up --no-start

echo "Restoring drupal backup ..."
for folder in modules profiles sites themes
do
    docker run --rm --volumes-from drupal -v $(pwd):/backup busybox sh -c "cd ${drupal_dir}/$folder && tar xf /backup/drupal_${folder}_backup.tar"
done
echo "drupal backup restored correctly."

echo "Restoring db backup ..."
docker run --rm --volumes-from db -v $(pwd):/backup busybox sh -c "cd $db_dir && tar xf /backup/db_backup.tar"
echo "db backup restored correctly."