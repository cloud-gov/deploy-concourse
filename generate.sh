#!/bin/sh

set -e -x

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

spruce merge --prune meta --prune terraform_outputs \
  $SCRIPTPATH/concourse.yml \
  $SCRIPTPATH/rds-ca-cert.yml \
  $@ \
> concourse-manifest/manifest.yml
