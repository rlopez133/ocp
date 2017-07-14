#!/bin/sh
DOMAIN=${DOMAIN:-ocp3.aitlabs.com}
netid0=$(openstack network list | awk "/public_network/ { print \$2 }")
netid1=$(openstack network list | awk "/tenant-network/ { print \$2 }")
for HOSTNUM in 0 ; do
  VOLUMEID=$(cinder list | awk "/infra-node-${HOSTNUM}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image rhel7 --key-name openshiftkp \
  --nic net-id=$netid0 \
  --nic net-id=$netid1,v4-fixed-ip="172.18.20.17" \
  --security-group infra-node-sg \
  --user-data=user-data/infra-node-${HOSTNUM}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  infra-node-${HOSTNUM}.${DOMAIN}
done
for HOSTNUM in 1 ; do
  VOLUMEID=$(cinder list | awk "/infra-node-${HOSTNUM}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image rhel7 --key-name openshiftkp \
  --nic net-id=$netid0 \
  --nic net-id=$netid1,v4-fixed-ip="172.18.20.19" \
  --security-group infra-node-sg \
  --user-data=user-data/infra-node-${HOSTNUM}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  infra-node-${HOSTNUM}.${DOMAIN}
done
