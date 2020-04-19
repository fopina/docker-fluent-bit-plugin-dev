#!/bin/sh

set -e

cd $(dirname $0)

VERSION="1.4.2.1"

docker build \
       -t fopina/fluent-bit-plugin-dev:${VERSION} \
       -t fopina/fluent-bit-plugin-dev:latest \
       .

docker push fopina/fluent-bit-plugin-dev:${VERSION}
docker push fopina/fluent-bit-plugin-dev:latest
