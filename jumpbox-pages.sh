#!/bin/bash
# vim: set ft=sh

set -e -u

# add some stuff to bashrc. Note that the variables and commands are evaluated when jumpbox.sh is executed
# NOT when .bashrc is, so we don't have to worry about rerunning things
cat <<EOF >> $HOME/.bashrc
# absolute paths for certs so we can run commands from any directory
export CREDHUB_CA_CERT="$(pwd)/${CREDHUB_CA_CERT}"
EOF


# Hack: Fail build to allow intercept; see https://github.com/concourse/concourse/issues/1160
exit 1
