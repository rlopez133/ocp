#!/bin/sh
DOMAIN=${DOMAIN:-control.ocp3.e2e.bos.redhat.com}
netid1=$(openstack network list | awk "/control-network/ { print \$2 }")
netid2=$(openstack network list | awk "/tenant-network/ { print \$2 }")
openstack server create --flavor m1.small --image rhel7 \
--key-name rlopez \
--nic net-id=$netid1 \
--nic net-id=$netid2 \
--security-group bastion-sg --user-data=user-data/bastion.yaml \
bastion-rl.${DOMAIN}
