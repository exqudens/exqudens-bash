#!/bin/bash

docker run \
--rm \
--name neo4j \
--publish=7474:7474 \
--publish=7687:7687 \
--env=NEO4J_AUTH=none \
--detach neo4j:4.0.1
