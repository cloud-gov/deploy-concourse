#!/bin/bash

set -eux

curl -o fly "${ATC_URL}/api/v1/cli?arch=amd64&platform=linux"
chmod +x ./fly

(
  set +x
  ./fly --target ci login \
    --concourse-url "${ATC_URL}" \
    --username "${BASIC_AUTH_USERNAME}" \
    --password "${BASIC_AUTH_PASSWORD}"
)


# Get list of workers
output=$(./fly --target ci workers)

if echo "${output}" | grep "the following workers have not checked in recently:"; then
  echo "Found a stalled worker..."
  echo $output
  exit 1
fi
