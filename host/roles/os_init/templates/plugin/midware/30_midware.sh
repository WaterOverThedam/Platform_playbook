#!/bin/bash
MID_PORT=(MID_PORT_VALUE)
arr_midport_length=${#MID_PORT[@]}
arr_midport_index=1

resdate=`date +%s`

arr_metric=("loggerret" "leader" "jvmmem" "dbconnpool" "codis" "redis" "fastdfs" "mq")
arr_length=${#arr_metric[@]}
out="["

for p in ${MID_PORT[@]}; do

	arr_index=1

	base_url="http://127.0.0.1:${p}/portal/action/hostcheck/check?type="
	url=""
	
	for v in ${arr_metric[@]}; do
		url=$base_url${v}
		ret=`curl -s $url`
		
		if [ ! $ret ] ; then
			ret=0
		fi
		
		if [ "$ret" == "true" ] ; then
			ret=1
		fi
		
		if [ "$ret" == "false" ] ; then
			ret=0
		fi
		
		metric="middleware."${v}

		out=${out}"{\"endpoint\": \"ENDPOINT_VALUE\", \"tags\": \"port=$p\", \"timestamp\": $resdate, \"metric\": \"$metric\", \"value\": $ret, \"counterType\": \"GAUGE\", \"step\": 30}"

		if [ $arr_index -ne $arr_length ] ; then
			out=${out}","
		fi
		arr_index=`expr $arr_index + 1`
	done
	
	if [ $arr_midport_index -ne $arr_midport_length ] ; then
		out=${out}","
	fi
	arr_midport_index=`expr $arr_midport_index + 1`
done

out=${out}"]"
echo $out