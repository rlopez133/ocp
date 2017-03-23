#!/bin/bash

/home/stack/ocp/snap_scripts/delete_servers.sh
/home/stack/ocp/paper_scripts/boot_master_fixedip.sh
/home/stack/ocp/snap_scripts/delete-cinder.sh
/home/stack/ocp/paper_scripts/create-cinder.sh
/home/stack/ocp/paper_scripts/boot_infra_nodes_fixedip.sh
/home/stack/ocp/paper_scripts/boot_app_nodes_fixedip.sh
sleep 3
/home/stack/ocp/snap_scripts/add_fixed_floatingip.sh
#sleep 3
#/home/stack/ocp/paper_scripts/disable-port-security.sh
