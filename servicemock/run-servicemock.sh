#!/bin/bash
docker run -i \
    -v $PWD/logs:/app/logs \
    -v $PWD/conf:/app/config \
    -e SERVICEMOCK_LOGS=/app/logs \
    -e SERVICEMOCK_NAME=servicemock \
    damianmcdonald/servicemock:1.2.0
