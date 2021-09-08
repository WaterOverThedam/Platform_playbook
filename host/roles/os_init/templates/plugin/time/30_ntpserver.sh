#!/bin/bash
ntpserver={{ntp_host}}
#ntp1.aliyun.com

ret=0;
ping -c 2 -w 100 $ntpserver
if [[ $? != 0 ]];then
  ret=1;
fi

resdate=`date +%s`
echo "[{\"endpoint\": \"0ed92fecef5a4648bdb7d4c998d0f8ad\", \"tags\": \"\", \"timestamp\": $resdate, \"metric\": \"ntpserver_state\", \"value\": $ret, \"counterType\": \"GAUGE\", \"step\": 30}]"
