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

if echo "${output}" | grep "stalled"; then
  echo "Found a stalled worker, will attempt to fix but will report this as an error..."
  echo $output
  
  echo "Attempting prune-worker command..."
  fix_output=$(./fly --target ci prune-worker --all-stalled)
  echo $fix_output
  
  exit 1
else
  echo "No stalled workers found."
fi
