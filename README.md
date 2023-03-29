# MongoDB container controller

## Install
1. Modify the configuration `db.conf`
    | Variable    | Description                |
    | ---         | ---                        |
    | DATABASE    | Name of the database       |
    | COLLECTION  | collection of the database |
    | MONGODB_DIR | path to save the database  |
    | NAME        | name of the container      |
1. Modify the variable in `setup_db.sh`
    | Variable | Description                             |
    | ---      | ---                                     |
    | WORKERS  | number of parallel to import json files |
    | JSON_DIR | directory with json files               |

## Usage
Run the `dbctl.sh` script to manipulate your MongoDB
```
$ bash dbctl.sh
Usage: bash dbctl.sh COMMAND [<mongo command>]

MongoDB controller

COMMANDS
  start   |  start the container
  stop    |  stop the container
  run     |  run the mongodb command
  count   |  return the total number of instances in database
```

### Example
```
$ bash dbctl.sh start
# f1a1...e795  # container hash name

$ bash dbctl.sh count
# 10           # number of instances in <database.collection>
```