#!/bin/bash

[ -z "$1" ] && echo "mysql主机IP不能为空" && exit 1
[ -z "$2" ] && echo "原soid不能为空" && exit 1
[ -z "$3" ] && echo "新soid不能为空" && exit 1

mysql -h $1 -uwinning -pMaria@win60.DB -D xxl-job -e "UPDATE XXL_JOB_QRTZ_TRIGGER_INFO SET executor_param=replace(executor_param,'$2','$3') WHERE executor_param LIKE '%$2%';"
