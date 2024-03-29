#!/bin/bash

# Go-Args: '-i /local/petstore.yaml -g go -o /local/out/go'
# Java-Args: '-g java --library okhttp-gson -i /local/Mastercard_Send_Disbursements-1.0.yaml -c /local/config.json -o /local/out/mastercard-disbursement-client'

docker run \
--rm \
--name 'openapi-generator-cli' \
--volume "${PWD}:/local" \
'openapitools/openapi-generator-cli' 'generate' "${@}" && \
sudo chown -hR andrew:andrew ./out/ && \
exit 0
