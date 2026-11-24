#!/bin/bash
# vim: set ft=sh

set -e -u

# CREDHUB_CA_CERT now arrives as PEM-encoded cert content (sourced from the
# bosh-director-info credhub variable) rather than a path to a file checked
# out from a resource. Write the content to a file so the credhub CLI --
# which requires a file path, not inline cert text -- can consume it, and
# export the resulting absolute path.
CERT_DIR="$HOME/certs"
mkdir -p "$CERT_DIR"

CREDHUB_CA_CERT_PATH="$CERT_DIR/credhub-ca.crt"

printf '%s\n' "$CREDHUB_CA_CERT" > "$CREDHUB_CA_CERT_PATH"

# add some stuff to bashrc. Note that the variables and commands are evaluated when jumpbox.sh is executed
# NOT when .bashrc is, so we don't have to worry about rerunning things
cat <<EOF >> $HOME/.bashrc
# absolute path to the cert file written above from the credhub cert content
export CREDHUB_CA_CERT="$CREDHUB_CA_CERT_PATH"
EOF


# Hack: Fail build to allow intercept; see https://github.com/concourse/concourse/issues/1160
exit 1
