#!/bin/bash

set -e

# build the base docker image used by app1 and app2
docker build -t dmp-nodejs .
# build the services
docker build -t app1 app1/
docker build -t app2 app2/