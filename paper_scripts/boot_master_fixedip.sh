#!/bin/sh
DOMAIN=${DOMAIN:-control.ocp3.e2e.bos.redhat.com}
netid1=$(openstack network list | awk "/control-network/ { print \$2 }")
netid2=$(openstack network list | awk "/tenant-network/ { print \$2 }")
for HOSTNUM in 0 ; do
  openstack server create --flavor m1.medium --image rhel7 --key-name rlopez \
  --nic net-id=$netid1,v4-fixed-ip="172.18.10.15" \
  --nic net-id=$netid2,v4-fixed-ip="172.18.20.16" \
  --security-group master-sg \
  --user-data=user-data/master-${HOSTNUM}.yaml \
  master-${HOSTNUM}.${DOMAIN}
done

for HOSTNUM in 1 ; do
  openstack server create --flavor m1.medium --image rhel7 --key-name rlopez \
  --nic net-id=$netid1,v4-fixed-ip="172.18.10.17" \
  --nic net-id=$netid2,v4-fixed-ip="172.18.20.20" \
  --security-group master-sg \
  --user-data=user-data/master-${HOSTNUM}.yaml \
  master-${HOSTNUM}.${DOMAIN}
done

for HOSTNUM in 2 ; do
  openstack server create --flavor m1.medium --image rhel7 --key-name rlopez \
  --nic net-id=$netid1,v4-fixed-ip="172.18.10.13" \
  --nic net-id=$netid2,v4-fixed-ip="172.18.20.6" \
  --security-group master-sg \
  --user-data=user-data/master-${HOSTNUM}.yaml \
  master-${HOSTNUM}.${DOMAIN}
done

