#!/bin/bash

. ../functions.sh

[ -z $1 ] && Echo_Red "环境编码不能为空" && exit 1

ansible-playbook -i ../hosts  upgrade_app_all.yml   -t 'params,check'  -e 'mode_change=False' --limit "$1:!dmts*" -v
