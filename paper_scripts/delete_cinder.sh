#!/bin/bash

for x in $(cinder list | awk '/docker/ {print $2}')
do
        cinder delete $x
done
