#!/bin/sh
BASTION="bastion-rl"
MASTERS="master-0 master-1 master-2"
INFRA_NODES="infra-node-0 infra-node-1"
APP_NODES="app-node-0 app-node-1 app-node-2"
ALL_NODES="$INFRA_NODES $APP_NODES"
ALL_HOSTS="$BASTION $MASTERS $ALL_NODES"

for H in $ALL_NODES $MASTERS
do
  ssh $H sudo systemctl enable lvm2-lvmetad
  ssh $H sudo systemctl start lvm2-lvmetad
done
