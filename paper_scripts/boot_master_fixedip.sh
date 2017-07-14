#!/bin/sh
DOMAIN=${DOMAIN:-ocp3.aitlabs.com}
netid0=$(openstack network list | awk "/public_network/ { print \$2 }")
netid1=$(openstack network list | awk "/tenant-network/ { print \$2 }")
for HOSTNUM in 0 ; do
  openstack server create --flavor m1.medium --image rhel7 --key-name openshiftkp \
  --nic net-id=$netid0 \
  --nic net-id=$netid1,v4-fixed-ip="172.18.20.14" \
  --security-group master-sg \
  --user-data=user-data/master-${HOSTNUM}.yaml \
  master-${HOSTNUM}.${DOMAIN}
done

for HOSTNUM in 1 ; do
  openstack server create --flavor m1.medium --image rhel7 --key-name openshiftkp \
  --nic net-id=$netid0 \
  --nic net-id=$netid1,v4-fixed-ip="172.18.20.15" \
  --security-group master-sg \
  --user-data=user-data/master-${HOSTNUM}.yaml \
  master-${HOSTNUM}.${DOMAIN}
done

for HOSTNUM in 2 ; do
  openstack server create --flavor m1.medium --image rhel7 --key-name openshiftkp \
  --nic net-id=$netid0 \
  --nic net-id=$netid1,v4-fixed-ip="172.18.20.16" \
  --security-group master-sg \
  --user-data=user-data/master-${HOSTNUM}.yaml \
  master-${HOSTNUM}.${DOMAIN}
done

