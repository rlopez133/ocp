#!/bin/sh
DOMAIN=${DOMAIN:-control.ocp3.e2e.bos.redhat.com}

openstack server add floating ip bastion-rl.${DOMAIN} 10.19.5.68
openstack server add floating ip master-0.${DOMAIN} 10.19.5.76
openstack server add floating ip master-1.${DOMAIN} 10.19.5.82
openstack server add floating ip master-2.${DOMAIN} 10.19.5.84
openstack server add floating ip infra-node-0.${DOMAIN} 10.19.5.96
openstack server add floating ip infra-node-1.${DOMAIN} 10.19.5.65
