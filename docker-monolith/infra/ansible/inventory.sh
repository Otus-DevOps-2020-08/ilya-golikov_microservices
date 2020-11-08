#!/bin/bash
echo "[docker_hosts]" > inv.tmp
yc compute instances list | tail -n +4 | head -n -2 | awk -F'|' '{print $3 " " "%ansible_host="$6 "\n"}' | tr -d '[:blank:]' | sed 's/%/ /g'  >> inv.tmp
ansible-inventory -i inv.tmp --list 2> /dev/null
rm -f inv.tmp
