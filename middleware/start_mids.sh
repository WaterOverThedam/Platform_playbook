#!/bin/bash

. ./functions.sh

[ -z $1 ] && Echo_Red "环境组名或主机名不能为空"  && exit 1
[ -z $2 ] && Echo_Red "中间件模块名不能为空" && exit 1
state="started"

if [ "$2" == "all" ];then
  echo ansible-playbook -i ../hosts.ini  systemctl_all.yml  --limit "$1" -e "state=$state"
  ansible-playbook -i ../hosts.ini  systemctl_all.yml   --limit "$1" -e "state=$state"
else
  echo  ansible-playbook -i ../hosts.ini systemctl_all.yml  --limit "$1" -t "var,$2" -e "state=$state"
  ansible-playbook -i ../hosts.ini systemctl_all.yml    --limit "$1" -t "var,$2" -e "state=$state"
fi
