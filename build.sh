#!/bin/sh

set -e

cd $(dirname $0)

VERSION="dev"

docker build \
       -t fopina/fluent-bit-plugin-dev:${VERSION} \
       # -t fopina/fluent-bit-plugin-dev:latest \
       .

# docker push fopina/fluent-bit-plugin-dev:${VERSION}
# docker push fopina/fluent-bit-plugin-dev:latest
