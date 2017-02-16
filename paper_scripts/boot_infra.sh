#!/bin/sh
DOMAIN=${DOMAIN:-control.ocp3.e2e.bos.redhat.com}
netid1=$(openstack network list | awk "/control-network/ { print \$2 }")
netid2=$(openstack network list | awk "/tenant-network/ { print \$2 }")
for HOSTNAME in infra-node-0 infra-node-1
do
  VOLUMEID=$(cinder list | awk "/${HOSTNAME}-docker/ { print \$2 }")
  openstack server create --flavor m1.medium --image rhel7 --key-name rlopez \
  --nic net-id=$netid1 --nic net-id=$netid2 \
  --security-group infra-node-sg --user-data=user-data/${HOSTNAME}.yaml \
  --block-device-mapping vdb=${VOLUMEID} \
  ${HOSTNAME}.${DOMAIN}
done

