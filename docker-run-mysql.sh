#!/bin/bash

docker run --rm --name mysql --publish=3306:3306 --env=MYSQL_ROOT_PASSWORD=root --detach mysql:8.0.19