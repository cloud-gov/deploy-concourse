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

# Calculate timestamp for 1 hour ago
one_hour_ago=$(date -d '1 hour ago' '+%Y-%m-%d %H:%M:%S')
# Get list of build audit events
output=$(./fly --target ci builds --since="$one_hour_ago")

# Get current timestamp components for S3 path
current_time=$(date -u '+%Y/%m/%d/%H/%M/%S')
epoch_time=$(date +%s)

# Create filename with .gz extension
filename="concourse-audit${epoch_time}.txt.gz"

# Create full S3 path
s3_path="s3://${BUCKET_NAME}/${current_time}/${filename}"

# Compress and write output to S3 with error handling
if echo "$output" | gzip | aws s3 cp - "$s3_path" --content-encoding gzip; then
    echo "Successfully uploaded compressed audit data to: $s3_path"
else
    echo "Failed to upload audit data to S3" >&2
    exit 1
fi