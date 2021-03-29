#!/bin/bash
# vim: set ft=sh

set -e -u

cat <<EOF >> $HOME/.bashrc
PS1="\[\$(tput setaf "$PROMPT_COLOR")\]\[\e]0;\u@$BOSH_DIRECTOR_NAME: \w\a\]${debian_chroot:+($debian_chroot)}\u@$BOSH_DIRECTOR_NAME:\w\$ \[\$(tput sgr0)\]"
EOF

export CREDHUB_CA_CERT="$(pwd)/${CREDHUB_CA_CERT}"
export BOSH_CACERT="$(pwd)/${BOSH_CACERT}"

# Hack: Fail build to allow intercept; see https://github.com/concourse/concourse/issues/1160
exit 1
