#!/bin/bash
RESOURCE_IP={{ops_addr}}
host_id={{hostvars[inventory_hostname].host_id}}

resdate=`date +%s`
srcdate=$(sudo ssh -o StrictHostKeyChecking=no -p {{hostvars.cloudhost.ansible_ssh_port if hostvars.cloudhost|default('')!='' else '22'}} root@$RESOURCE_IP date +%s)
timediff=$(($srcdate - $resdate))

if [ $timediff -ge 43200 ]; then
	timediff=43200
else
	timediff=`sudo clockdiff -o $RESOURCE_IP | awk '{print $2}'`
fi
resdate=`date +%s`
echo "[{\"endpoint\": \"${host_id}\", \"tags\": \"\", \"timestamp\": $resdate, \"metric\": \"time_offset\", \"value\": $timediff, \"counterType\": \"GAUGE\", \"step\": 30}]"
