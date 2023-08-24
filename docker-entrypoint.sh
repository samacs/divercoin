#!/usr/bin/env sh

set -e

if [ -f tmp/pids/server.pid ]; then
    rm -rf tmp/pids/server.pid
fi

if [ -f package.json ]; then
    yarn check --verify-tree || yarn install
fi

bundle check || bundle install

exec "$@"
