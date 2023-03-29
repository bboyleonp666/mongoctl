#!/bin/bash

source db.conf

count() {
    docker exec $NAME mongosh --quiet --eval "use $DATABASE" --eval "db.$COLLECTION.find().count()"
}

count
