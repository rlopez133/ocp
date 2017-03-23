#!/bin/sh
DOMAIN=${DOMAIN:-control.ocp3.e2e.bos.redhat.com}
netid1=$(openstack network list | awk "/control-network/ { print \$2 }")
netid2=$(openstack network list | awk "/tenant-network/ { print \$2 }")
for HOSTNUM in 0 ; do
  VOLUMEID=$(cinder list | awk "/app-node-${HOSTNUM}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image rhel7 --key-name rlopez \
  --nic net-id=$netid1,v4-fixed-ip="172.18.10.9" \
  --nic net-id=$netid2,v4-fixed-ip="172.18.20.13" \
  --security-group app-node-sg \
  --user-data=user-data/app-node-${HOSTNUM}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  app-node-${HOSTNUM}.${DOMAIN}
done
for HOSTNUM in 1 ; do
  VOLUMEID=$(cinder list | awk "/app-node-${HOSTNUM}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image rhel7 --key-name rlopez \
  --nic net-id=$netid1,v4-fixed-ip="172.18.10.14" \
  --nic net-id=$netid2,v4-fixed-ip="172.18.20.12" \
  --security-group app-node-sg \
  --user-data=user-data/app-node-${HOSTNUM}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  app-node-${HOSTNUM}.${DOMAIN}
done

for HOSTNUM in 2 ; do
  VOLUMEID=$(cinder list | awk "/app-node-${HOSTNUM}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image rhel7 --key-name rlopez \
  --nic net-id=$netid1,v4-fixed-ip="172.18.10.18" \
  --nic net-id=$netid2,v4-fixed-ip="172.18.20.5" \
  --security-group app-node-sg \
  --user-data=user-data/app-node-${HOSTNUM}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  app-node-${HOSTNUM}.${DOMAIN}
done

