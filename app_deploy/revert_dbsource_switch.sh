#/bin/bash

. ../functions.sh

main() {
    [ -z $* ] && Echo_Red "主机名不能为空" && exit 1
    params[${#params[*]}]="replace_enable=true"
    params[${#params[*]}]="revert_enable=true"
    [ ! -z $2 ] && params[${#params[*]}]="filters=$2"


    ansible-playbook -i ../hosts.ini app_restart.yml  --limit "$1" -e "${params[*]}"
    return $?
}

main $*
