#!/bin/sh

set -e -x

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

CONFIG=""
SECRETS=$SCRIPTPATH/secrets.yml
TERRAFORM=$SCRIPTPATH/terraform.yml
MANIFEST=$SCRIPTPATH/manifest.yml
if [ ! -z "$1" ]; then
  CONFIG=$1
fi
if [ ! -z "$2" ]; then
  SECRETS=$2
fi
if [ ! -z "$3" ]; then
  TERRAFORM=$3
fi
if [ ! -z "$4" ]; then
  MANIFEST=$4
fi

spruce merge --prune meta --prune terraform_outputs \
  $SCRIPTPATH/concourse.yml \
  $CONFIG \
  $SECRETS \
  $TERRAFORM \
  > $MANIFEST
