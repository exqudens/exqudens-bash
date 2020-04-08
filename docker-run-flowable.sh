#!/bin/bash

docker run \
--rm \
--detach \
--name 'flowable' \
--publish '8080:8080' \
--env 'SERVER_PORT=9977' \
'flowable/all-in-one:6.5.0'
