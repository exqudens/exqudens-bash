#!/bin/bash

docker run \
--rm \
--detach \
--name 'flowable' \
--publish '8080:8080' \
'flowable/all-in-one:6.5.0' && \

echo 'uri=http://localhost:8080/flowable-modeler' && \
echo 'username=admin' && \
echo 'password=test' && \

exit 0
