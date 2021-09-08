#!/bin/bash
RESOURCE_IP={{ops_addr}}
RESOURCE_PASSWORD=Win.2020
host_id={{hostvars[inventory_hostname].host_id}}

resdate=`date +%s`

srcdate=$(sudo expect -c "
    set timeout -1
    spawn ssh winning@$RESOURCE_IP \"echo \`date +%s\`\"
    expect {
        \"*assword\" {send \"$RESOURCE_PASSWORD\r\";}
                \"yes/no\" {send \"yes\r\"; exp_continue;}
    }
    expect eof"|awk 'END {print $1}')

srcdate=$(sudo expect -c "
    set timeout 36
    spawn ssh -o StrictHostKeyChecking=no root@$RESOURCE_IP \"echo \`date +%s\`\"
    expect eof"|awk 'END {print $1}')
    
#srcdate=`cat /tmp/timeoffset | awk 'END{print $1}'`
# srcdate=`echo "${srcdate// /}"`
srcdate=`echo ${srcdate}`
srcdate=`echo "${srcdate}" | awk '{print int($0)}'` 
# echo "srcdateff====${srcdate}"
# echo "resdateff====$resdate"
# timediff=`expr $srcdate - $resdate`
timediff=$(($srcdate - $resdate))
# echo "timediff=$timediff"
if [ $timediff -ge 43200 ]; then
	timediff=43200
else
	timediff=`sudo clockdiff -o $RESOURCE_IP | awk '{print $2}'`
fi
resdate=`date +%s`
echo "[{\"endpoint\": \"${host_id}\", \"tags\": \"\", \"timestamp\": $resdate, \"metric\": \"time_offset\", \"value\": $timediff, \"counterType\": \"GAUGE\", \"step\": 30}]"
