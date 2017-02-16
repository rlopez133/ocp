#!/bin/bash

for y in $(openstack floating ip list | awk "/None/ { print \$4 }")
do
        openstack floating ip delete $y
done

