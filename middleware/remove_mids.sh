#!/bin/bash

. ./functions.sh

[ -z $1 ] && Echo_Red "环境组名或主机名不能为空"  && exit 1
[ -z $2 ] && Echo_Red "中间件模块名不能为空" && exit 1

if [ "$2" == "all" ];then
  ./stop_mids.sh $1 $2
  echo ansible-playbook -i ../hosts.ini  remove_all.yml  --limit "$1"
  ansible-playbook -i ../hosts.ini  remove_all.yml   --limit "$1"
else
  ./stop_mids.sh $1 $2
  echo  ansible-playbook -i ../hosts.ini remove_all.yml   --limit "$1" -t "$2"
  ansible-playbook -i ../hosts.ini remove_all.yml --limit "$1" -t "$2"
fi
