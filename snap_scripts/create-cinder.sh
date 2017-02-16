#!/bin/sh
VOLUME_SIZE=${VOLUME_SIZE:-4}
BASTION="bastion-rl"
MASTERS="master-0 master-1 master-2"
INFRA_NODES="infra-node-0 infra-node-1"
APP_NODES="app-node-0 app-node-1 app-node-2"
ALL_NODES="$INFRA_NODES $APP_NODES"
ALL_HOSTS="$BASTION $MASTERS $ALL_NODES"

for NODE in $ALL_NODES ; do
    cinder create --name ${NODE}-docker ${VOLUME_SIZE}
done

cinder list
