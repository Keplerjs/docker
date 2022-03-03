#!/bin/bash

echo "build.sh create meteor bundle..."

export NODE_TLS_REJECT_UNAUTHORIZED=0
export METEOR_ALLOW_SUPERUSER=true
env
cd /kepler-src
ls -lar .meteor/
sleep 5
chmod -R 700 .meteor

meteor npm install --production --unsafe-perm
meteor build --directory /kepler --server=$ROOT_URL:$PORT

cd /kepler/bundle/programs/server

meteor npm install --unsafe-perm
