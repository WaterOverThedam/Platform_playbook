#!/bin/bash
. ../functions.sh

[ -z $1 ] && Echo_Red "环境编码不能为空" && exit 1

user=$2
force=$3
force=${force:=no}
user=${user:=winning}
ansible-playbook -i ../hosts  upgrade_app_all.yml -e "mode_change=False group_name=$1 force=${force} ansible_ssh_user=${user}" --limit "$1" -v
