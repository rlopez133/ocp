#!/bin/bash

openstack server add floating ip infra-node-0.control.osp10.e2e.bos.redhat.com 10.19.114.154
openstack server add floating ip infra-node-1.control.osp10.e2e.bos.redhat.com 10.19.114.150
openstack server add floating ip master-0.control.osp10.e2e.bos.redhat.com 10.19.114.142
openstack server add floating ip master-1.control.osp10.e2e.bos.redhat.com 10.19.114.153
openstack server add floating ip master-2.control.osp10.e2e.bos.redhat.com 10.19.114.155

