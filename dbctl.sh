#!/bin/bash

source db.conf

start() {
    # echo "docker run --name $NAME -v $MONGODB_DIR:/data/db -d --rm mongo:6.0.5"
    docker run --name $NAME -v $MONGODB_DIR:/data/db -d --rm mongo:6.0.5
}

stop() {
    # echo "docker stop $NAME"
    docker stop $NAME
}

count() {
    # echo "docker exec $NAME mongosh --quiet --eval \"use $DATABASE\" --eval \"db.$COLLECTION.find().count()\""
    docker exec $NAME mongosh --quiet --eval "use $DATABASE" --eval "db.$COLLECTION.find().count()"
}

run() {
    [[ $1 == '' ]] && echo 'No mongo command provided' && exit 1
    cmd=$(echo $1 | sed 's/ //g')
    # echo "docker exec $NAME mongosh --quiet --eval \"use $DATABASE\" --eval \"$cmd\""
    docker exec $NAME mongosh --quiet --eval "use $DATABASE" --eval "$cmd"
}

usage() {
    echo "Usage: bash dbctl.sh COMMAND [<mongo command>]"
    echo ""
    echo "MongoDB controller"
    echo ""
    echo "COMMANDS"
    echo "  start   |  start the container"
    echo "  stop    |  stop the container"
    echo "  run     |  run the mongodb command"
    echo "  count   |  return the total number of instances in database"
}

[[ $1 == '' ]] && usage && exit 0
if [[ $1 == 'start' ]]; then
    start
elif [[ $1 == 'stop' ]]; then
    stop
elif [[ $1 == 'run' ]]; then
    run "$2"
elif [[ $1 == 'count' ]]; then
    count
else
    echo 'Command not supported!' && exit 1
fi

