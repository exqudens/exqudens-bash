#!/bin/bash

docker run --rm --name mysql-server --publish=3306:3306 --env=MYSQL_ROOT_PASSWORD=root --env=MYSQL_ONETIME_PASSWORD=false --detach mysql/mysql-server:8.0
