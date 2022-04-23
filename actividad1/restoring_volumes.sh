#!/bin/bash

set -e

echo "Creating containers if missing ..."
docker-compose up --no-start
echo "Restoring backup ..."
docker run --rm --volumes-from drupal -v $(pwd):/backup busybox tar xf /backup/drupal_backup.tar
docker run --rm --volumes-from db -v $(pwd):/backup busybox tar xf /backup/db_backup.tar
echo "Backup restored correctly."