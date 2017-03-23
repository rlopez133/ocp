#!/bin/bash

for x in $(openstack server list | awk '/com/ {print $2}'| grep -v 898a5b03-f8a1-4b89-9d14-3bb824bcc423)
do
        openstack server delete $x
done

