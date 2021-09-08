#!/bin/bash
. ../functions.sh

 [ -z $1 ] && Echo_Red "环境编码不能为空" && exit 1

 find ./ -name '*.sh'|xargs chmod +x 
 ansible-playbook -i ../hosts  generate_param_by_shell.yml  --limit "$1" -v
