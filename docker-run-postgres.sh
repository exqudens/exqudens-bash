#!/bin/bash

docker run \
--rm \
--detach \
--name 'postgres' \
--publish '5432:5432' \
--env 'POSTGRES_HOST_AUTH_METHOD=trust' \
--env 'POSTGRES_DB=test_db' \
--env 'POSTGRES_USER=test_user' \
--env 'POSTGRES_PASSWORD=test_pass' \
'postgres:12.2' && \

echo 'PORT=5432' && \
echo 'DB=test_db' && \
echo 'USER=test_user' && \
echo 'PASSWORD=test_pass' && \

exit 0
