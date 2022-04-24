#!/bin/bash

set -e

echo "Creating containers if missing ..."
docker-compose up --no-start
for value in drupal db
do
    echo "Restoring $value backup ..."
    docker run --rm --volumes-from $value -v $(pwd):/backup busybox tar xf /backup/${value}_backup.tar
    echo "$value backup restored correctly."
done