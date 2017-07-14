#!/bin/sh
DOMAIN=${DOMAIN:-ocp3.aitlabs.com}
netid0=$(openstack network list | awk "/public_network/ { print \$2 }")
netid1=$(openstack network list | awk "/tenant-network/ { print \$2 }")
for HOSTNUM in 0 ; do
  VOLUMEID=$(cinder list | awk "/app-node-${HOSTNUM}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image rhel7 --key-name openshiftkp \
  --nic net-id=$netid0 \
  --nic net-id=$netid1,v4-fixed-ip="172.18.20.20" \
  --security-group app-node-sg \
  --user-data=user-data/app-node-${HOSTNUM}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  app-node-${HOSTNUM}.${DOMAIN}
done
for HOSTNUM in 1 ; do
  VOLUMEID=$(cinder list | awk "/app-node-${HOSTNUM}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image rhel7 --key-name openshiftkp \
  --nic net-id=$netid0 \
  --nic net-id=$netid1,v4-fixed-ip="172.18.20.21" \
  --security-group app-node-sg \
  --user-data=user-data/app-node-${HOSTNUM}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  app-node-${HOSTNUM}.${DOMAIN}
done

for HOSTNUM in 2 ; do
  VOLUMEID=$(cinder list | awk "/app-node-${HOSTNUM}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image rhel7 --key-name openshiftkp \
  --nic net-id=$netid0 \
  --nic net-id=$netid1,v4-fixed-ip="172.18.20.22" \
  --security-group app-node-sg \
  --user-data=user-data/app-node-${HOSTNUM}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  app-node-${HOSTNUM}.${DOMAIN}
done

