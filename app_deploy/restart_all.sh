#/bin/bash

. ../functions.sh

main() {
    declare -a params;
    [ -z $1 ] && Echo_Red "主机名不能为空" && exit 1
    params[${#params[*]}]="ansible_ssh_user=winning"
    [ ! -z $2 ] && params[${#params[*]}]="filters=$2"

    echo  ansible-playbook -i ../hosts.ini app_restart.yml  --limit "$1:!dmts*"  -e "${params[*]}"
    ansible-playbook -i ../hosts.ini app_restart.yml  --limit "$1:!dmts*"  -e "${params[*]}"
    return $?
}

main $*
