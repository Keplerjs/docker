#!/bin/bash
#

# METEOR_SETTINGS=$(cat settings.json)
# ROOT_URL="https://<APPDOMAIN>"
# BIND_IP=<IPADDRESS>
# PORT=<PORT>
#
export METEOR_SETTINGS=$(node env2settings.js settings.json)

#printenv | sort

echo "Listen on ${ROOT_URL}:${PORT}"
#echo "${METEOR_SETTINGS}"

node ./bundle/main.js