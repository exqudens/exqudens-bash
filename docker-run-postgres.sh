#!/bin/bash

docker run --rm \
--name mysql \
--publish=5432:5432 \
--env=POSTGRES_HOST_AUTH_METHOD=trust \
--env=POSTGRES_DB=test_db \
--env=POSTGRES_USER=test_user \
--env=POSTGRES_PASSWORD=test_pass \
--detach postgres:12.2
