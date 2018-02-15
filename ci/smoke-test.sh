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

cat > config.yml << EOF
platform: linux

image_resource:
  type: docker-image
  source:
    repository: busybox

run:
  path: echo
  args: ["smoke"]
EOF

output=$(./fly --target ci execute --config ./config.yml)

if ! echo "${output}" | grep smoke; then
  echo "Expected to find 'smoke' in output"
  exit 1
fi
