#!/bin/sh
DOMAIN=${DOMAIN:-ocp3.aitlabs.com}
netid0=$(openstack network list | awk "/public_network/ { print \$2 }")
netid1=$(openstack network list | awk "/tenant-network/ { print \$2 }")
openstack server create --flavor m1.medium --image rhel7 \
--key-name openshiftkp \
--nic net-id=$netid0 \
--nic net-id=$netid1,v4-fixed-ip="172.18.20.13" \
--security-group bastion-sg --user-data=user-data/bastion.yaml \
bastion.${DOMAIN}
