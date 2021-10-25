#/bin/bash

. ../functions.sh

main() {
    declare -a params;
    [ -z $1 ] && Echo_Red "主机名不能为空" && exit 1
    [ ! -z $2 ] && params[${#params[*]}]="filters=$2"

    echo  ansible-playbook -i ../hosts.ini app_restart.yml  --limit "$1"  -e "${params[*]}"
    ansible-playbook -i ../hosts.ini app_restart.yml  --limit "$1"  -e "${params[*]}"
    return $?
}

main $*
