#!/bin/bash

. ../../functions.sh

main() {
    [ -z $1 ] && Echo_Red "环境编码不能为空" && exit 1
    declare -a params
    params[${#params[*]}]="group_name=$1"

    echo ansible-playbook -i ../../hosts.ini install.yml -e "${params[*]}" --limit "$1"
    ansible-playbook -i ../../hosts.ini install.yml -e "${params[*]}" --limit "$1"

    return $?
}

main $*
