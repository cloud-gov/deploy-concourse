#!/bin/bash

set -eux

curl -o fly "${CONCOURSE_URL}/api/v1/cli?arch=amd64&platform=linux"
chmod +x ./fly
fly="./fly"

${fly} -t ci login -c "${CONCOURSE_URL}" -u "${CONCOURSE_USERNAME}" -p "${CONCOURSE_PASSWORD}"

for worker in $(${fly} -t ci workers | grep stalled | awk '{print $1}'); do
  ${fly} -t ci prune-worker -w "${worker}"
done
