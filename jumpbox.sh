#!/bin/bash
# vim: set ft=sh

set -e -u

#
# Configure legacy bosh
#
bosh --ca-cert $BOSH_CACERT -n target $BOSH_ENVIRONMENT

if [ -n "${BOSH_USERNAME}" ]; then
  bosh login <<EOF 1>/dev/null
$BOSH_USERNAME
$BOSH_PASSWORD
EOF
fi

#
# Configure bosh-cli
#
bosh-cli -n --ca-cert ${BOSH_CACERT} alias-env env

if [ -n "${BOSH_USERNAME:-}" ]; then
  # Hack: Add trailing newline to skip OTP prompt
  bosh-cli log-in <<EOF 1>/dev/null
${BOSH_USERNAME}
${BOSH_PASSWORD}

EOF
fi

cat <<EOF >> $HOME/.bashrc
PS1="\[\$(tput setaf "$PROMPT_COLOR")\]\[\e]0;\u@$BOSH_DIRECTOR_NAME: \w\a\]${debian_chroot:+($debian_chroot)}\u@$BOSH_DIRECTOR_NAME:\w\$ \[\$(tput sgr0)\]"
EOF

# Hack: Fail build to allow intercept; see https://github.com/concourse/concourse/issues/1160
exit 1
