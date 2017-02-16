#!/bin/sh
DOMAIN=${DOMAIN:-control.ocp3.e2e.bos.redhat.com}
netid1=$(openstack network list | awk "/control-network/ { print \$2 }")
netid2=$(openstack network list | awk "/tenant-network/ { print \$2 }")
for HOSTNUM in 0 1; do
  VOLUMEID=$(cinder list | awk "/app-node-${HOSTNUM}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image master-infra-app-nodes-2017-02-16-snap --key-name rlopez \
  --nic net-id=$netid1 \
  --nic net-id=$netid2 \
  --security-group app-node-sg --user-data=user-data/app-node-${HOSTNUM}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  app-node-${HOSTNUM}.${DOMAIN}
done
