#!/bin/bash

. ./functions.sh

main() {
    [ -z $1 ] && Echo_Red "环境编码不能为空" && exit 1
    [ -z $2 ] && Echo_Red "中间件模块名不能为空" && exit 1
    declare -a params

    params[${#params[*]}]="group_name=$1"
    [ ! -z $3 ] && params[${#params[*]}]="ngx_vip=$3"
    [ $2 = 'health' ] && params[${#params[*]}]="gather_facts=False" 

    if [ "$2" == "all" ]; then
        echo ansible-playbook -i ../hosts.ini install_all.yml -e "${params[*]}" --limit "$1"
        ansible-playbook -i ../hosts.ini install_all.yml -e "${params[*]}" --limit "$1"
    else
        echo ansible-playbook -i ../hosts.ini install_all.yml -e "${params[*]}" --limit "$1" -t "targets,health,$2"
        ansible-playbook -i ../hosts.ini install_all.yml -e "${params[*]}" --limit "$1" -t "targets,health,$2"
    fi

    return $?
}

main $*
