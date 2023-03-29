#!/bin/bash

# configuration
## mongodb
source db.conf

WORKERS=8
JSON_DIR=/home/leon/data/mal_results

import_script=import_vtreports.sh

# start container
mkdir -p $MONGODB_DIR
docker run --name $NAME -v $MONGODB_DIR:/data/db -v $JSON_DIR:/jsons -d --rm mongo:6.0.5

## generate import script
cat > $import_script <<EOF
#!/bin/bash

find /jsons -type f -name '*.json' | xargs -P $WORKERS -I {} mongoimport {} -d $DATABASE -c $COLLECTION
EOF
sed -i "s/\$WORKERS/$WORKERS/" $import_script
sed -i "s/\$DATABASE/$DATABASE/" $import_script
sed -i "s/\$COLLECTION/$COLLECTION/" $import_script

docker cp $import_script $NAME:/$import_script
rm $import_script
docker exec $NAME bash /$import_script
docker stop $NAME
