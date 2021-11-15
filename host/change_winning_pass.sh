#/bin/bash

[ -z $1 ] && echo "环境组编码不能为空"  && exit 1

ansible-playbook -i ../hosts.ini  change_winning_pass.yml -e "group_name=$1" -v