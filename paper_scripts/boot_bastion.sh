#!/bin/sh
DOMAIN=${DOMAIN:-control.ocp3.e2e.bos.redhat.com}
netid1=$(openstack network list | awk "/control-network/ { print \$2 }")
netid2=$(openstack network list | awk "/tenant-network/ { print \$2 }")
openstack server create --flavor m1.small --image rhel7 \
--key-name rlopez \
--nic net-id=$netid1,v4-fixed-ip="172.18.10.7" \
--nic net-id=$netid2,v4-fixed-ip="172.18.20.10" \
--security-group bastion-sg --user-data=user-data/bastion.yaml \
bastion-rl.${DOMAIN}
