#!/bin/bash
# vim: set ft=sh

set -e -u

# CREDHUB_CA_CERT and BOSH_CA_CERT now arrive as PEM-encoded cert content
# (sourced from the bosh-director-info credhub variable) rather than a path
# to a file checked out from a resource. Write the content to files so the
# bosh/credhub CLIs -- which require a file path, not inline cert text --
# can consume them, and export the resulting absolute paths.
CERT_DIR="$HOME/certs"
mkdir -p "$CERT_DIR"

CREDHUB_CA_CERT_PATH="$CERT_DIR/credhub-ca.crt"
BOSH_CA_CERT_PATH="$CERT_DIR/bosh-ca.crt"

printf '%s\n' "$CREDHUB_CA_CERT" > "$CREDHUB_CA_CERT_PATH"
printf '%s\n' "$BOSH_CA_CERT" > "$BOSH_CA_CERT_PATH"

# add some stuff to bashrc. Note that the variables and commands are evaluated when jumpbox.sh is executed
# NOT when .bashrc is, so we don't have to worry about rerunning things
cat <<EOF >> $HOME/.bashrc
# add director name to terminal to reduce chances of running commands in the wrong env
PS1="\[\$(tput setaf "$PROMPT_COLOR")\]\[\e]0;\u@$BOSH_DIRECTOR_NAME: \w\a\]${debian_chroot:+($debian_chroot)}\u@$BOSH_DIRECTOR_NAME:\w\$ \[\$(tput sgr0)\]"
# absolute paths to the cert files written above from the credhub cert content
export CREDHUB_CA_CERT="$CREDHUB_CA_CERT_PATH"
export BOSH_CA_CERT="$BOSH_CA_CERT_PATH"
EOF


# Hack: Fail build to allow intercept; see https://github.com/concourse/concourse/issues/1160
exit 1
