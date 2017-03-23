#!/bin/sh
DOMAIN=${DOMAIN:-control.ocp3.e2e.bos.redhat.com}
netid1=$(openstack network list | awk "/control-network/ { print \$2 }")
netid2=$(openstack network list | awk "/tenant-network/ { print \$2 }")
for HOSTNUM in 0 ; do
  VOLUMEID=$(cinder list | awk "/infra-node-${HOSTNUM}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image rhel7 --key-name rlopez \
  --nic net-id=$netid1,v4-fixed-ip="172.18.10.21" \
  --nic net-id=$netid2,v4-fixed-ip="172.18.20.30" \
  --security-group infra-node-sg \
  --user-data=user-data/infra-node-${HOSTNUM}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  infra-node-${HOSTNUM}.${DOMAIN}
done
for HOSTNUM in 1 ; do
  VOLUMEID=$(cinder list | awk "/infra-node-${HOSTNUM}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image rhel7 --key-name rlopez \
  --nic net-id=$netid1,v4-fixed-ip="172.18.10.22" \
  --nic net-id=$netid2,v4-fixed-ip="172.18.20.31" \
  --security-group infra-node-sg \
  --user-data=user-data/infra-node-${HOSTNUM}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  infra-node-${HOSTNUM}.${DOMAIN}
done
