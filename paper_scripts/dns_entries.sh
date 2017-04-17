#!/bin/bash

nsupdate -k /home/stack/update.key <<EOF
server 10.19.114.145
zone osp10.e2e.bos.redhat.com
update add master-0.osp10.e2e.bos.redhat.com 300 A 10.19.114.142
update add master-0.control.osp10.e2e.bos.redhat.com 300 A 172.18.10.15
update add master-1.control.osp10.e2e.bos.redhat.com 300 A 172.18.10.17
update add master-2.control.osp10.e2e.bos.redhat.com 300 A 172.18.10.13
update add master-1.osp10.e2e.bos.redhat.com 300 A 10.19.114.153
update add master-2.osp10.e2e.bos.redhat.com 300 A 10.19.114.155
update add infra-node-0.control.osp10.e2e.bos.redhat.com 300 A 172.18.10.21
update add infra-node-1.control.osp10.e2e.bos.redhat.com 300 A 172.18.10.22
update add infra-node-0.osp10.e2e.bos.redhat.com 300 A 10.19.114.154
update add infra-node-1.osp10.e2e.bos.redhat.com 300 A 10.19.114.150
update add bastion-rl.osp10.e2e.bos.redhat.com 300 A 10.19.114.141
update add bastion-rl.control.osp10.e2e.bos.redhat.com 300 A 172.18.10.7
update add app-node-0.control.osp10.e2e.bos.redhat.com 300 A 172.18.10.9
update add app-node-1.control.osp10.e2e.bos.redhat.com 300 A 172.18.10.14
update add app-node-2.control.osp10.e2e.bos.redhat.com 300 A 172.18.10.18
update add devs.osp10.e2e.bos.redhat.com 300 A 10.19.114.146
update add *.apps.osp10.e2e.bos.redhat.com 300 A 10.19.114.146
send
quit
EOF
