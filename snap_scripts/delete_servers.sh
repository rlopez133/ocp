#!/bin/bash

for x in $(openstack server list | awk '/com/ {print $2}')
do
        openstack server delete $x
done

