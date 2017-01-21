#!/bin/bash
# vim: set ft=sh

set -e -u

#
# Configure legacy bosh
#
bosh --ca-cert $BOSH_CACERT -n target $BOSH_TARGET

if [ -n "${BOSH_USERNAME}" ]; then
  bosh login <<EOF 1>/dev/null
$BOSH_USERNAME
$BOSH_PASSWORD
EOF
fi

#
# Configure bosh-cli
#
bosh-cli -n -e ${BOSH_TARGET} --ca-cert ${BOSH_CACERT} alias-env env

if [ -n "${BOSH_USERNAME:-}" ]; then
  # Hack: Add trailing newline to skip OTP prompt
  bosh-cli -e env log-in <<EOF 1>/dev/null
${BOSH_USERNAME}
${BOSH_PASSWORD}

EOF
fi
